function ALLEEG = p1_import_bids(cfg)
% Import HBN BIDS dataset for one task using pop_importbids.
%
% Returns ALLEEG (array of EEG structs), one per subject/session.
% Raw sets are written to <cfg.deriv_root>/raw/ for checkpoint recovery.
%
% Requires: EEGLAB 2024+ with Biosig plugin.

out_dir = fullfile(cfg.deriv_root, 'raw');
if ~exist(out_dir, 'dir'), mkdir(out_dir); end

import_opts = { ...
    'outputdir',   out_dir, ...
    'task',        cfg.task, ...
    'bidsevent',   'on', ...
    'bidschanloc', 'on' };

if ~isempty(cfg.subjects)
    import_opts = [import_opts, {'subjects', cfg.subjects}];
end

[~, ALLEEG] = pop_importbids(cfg.bids_root, import_opts{:});

fprintf('[p1_import_bids] Imported %d dataset(s) for task %s.\n', ...
    length(ALLEEG), cfg.task);
end
