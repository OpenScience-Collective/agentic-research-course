function run_phase1(cfg_name)
% Phase 1 master script: BIDS import -> highpass -> cleanline -> channel rejection.
%
% Usage (interactive):
%   run_phase1('r3mini')
%
% Usage (command line, from repo root):
%   matlab -nodisplay -nosplash \
%     -r "addpath(genpath('sessions/week-03/practicum')); run_phase1('r3mini'); exit"
%
% cfg_name: name suffix for a config function in practicum/config/.
%   'r3mini' loads config/cfg_r3mini.m (default).
%   Add cfg_r3full.m for the full 183-subject run once R3-mini validates.
%
% Outputs:
%   derivatives/preproc/<subject>_preproc.set  -- cleaned continuous EEG
%   derivatives/preproc/phase1_report.mat      -- channel rejection summary

if nargin < 1, cfg_name = 'r3mini'; end

% Resolve paths relative to this file so the script is location-independent.
script_dir   = fileparts(mfilename('fullpath'));
practicum_dir = fullfile(script_dir, '..');
addpath(genpath(practicum_dir));

% Load configuration.
cfg_fn = str2func(['cfg_' cfg_name]);
cfg    = cfg_fn();

% Ensure output directories exist.
preproc_dir = fullfile(cfg.deriv_root, 'preproc');
if ~exist(preproc_dir, 'dir'), mkdir(preproc_dir); end

fprintf('\n=== Phase 1: Preprocessing (%s) ===\n\n', cfg_name);

eeglab nogui;

% Step 1: Import BIDS.
fprintf('Step 1/4: Import BIDS...\n');
ALLEEG = p1_import_bids(cfg);

% Step 2: Highpass filter.
fprintf('\nStep 2/4: Highpass filter (%.1f Hz)...\n', cfg.highpass_hz);
ALLEEG = p1_highpass(ALLEEG, cfg);

% Step 3: CleanLine.
fprintf('\nStep 3/4: CleanLine (%s Hz)...\n', num2str(cfg.cleanline_hz));
ALLEEG = p1_cleanline(ALLEEG, cfg);

% Step 4: Channel rejection.
fprintf('\nStep 4/4: Channel rejection...\n');
[ALLEEG, report] = p1_channel_reject(ALLEEG, cfg);

% Save preprocessed sets.
fprintf('\nSaving to %s...\n', preproc_dir);
for i = 1:length(ALLEEG)
    out_name = sprintf('%s_preproc.set', ALLEEG(i).subject);
    pop_saveset(ALLEEG(i), 'filename', out_name, 'filepath', preproc_dir);
    fprintf('  Saved: %s\n', out_name);
end

% Save channel rejection report.
report_path = fullfile(preproc_dir, 'phase1_report.mat');
save(report_path, 'report', 'cfg');
fprintf('\nChannel rejection report saved: %s\n', report_path);

% Print summary table.
fprintf('\n--- Channel retention summary ---\n');
fprintf('%-30s  %5s  %5s  %5s\n', 'Subject', 'Orig', 'Kept', 'Rej');
for i = 1:length(report)
    fprintf('%-30s  %5d  %5d  %5d\n', ...
        report(i).subject, report(i).n_orig, report(i).n_kept, report(i).n_rejected);
end

n_warn = sum([report.n_kept] ./ [report.n_orig] < 0.90);
if n_warn > 0
    fprintf('\nWARNING: %d subject(s) retained <90%% channels. Inspect before Phase 2.\n', n_warn);
end

fprintf('\n=== Phase 1 complete ===\n');
end
