function [ALLEEG, report] = p1_channel_reject(ALLEEG, cfg)
% Reject bad channels using clean_rawdata (channel-level criteria only).
%
% ASR (artifact subspace reconstruction) and window rejection are explicitly
% disabled -- those steps would alter the continuous signal in ways that
% interact with ICA (Phase 2). Channel rejection here only removes electrodes
% that are flat, noisy, or poorly correlated with neighbors.
%
% Thresholds from cfg (see cfg_r3mini.m for values and justification):
%   ChannelCriterion:     minimum correlation with neighbor channels
%   FlatlineCriterion:    max seconds of flat signal before rejection
%   LineNoiseCriterion:   residual line-noise Z-score after CleanLine
%
% Returns report: struct array with subject ID and channel counts.
%
% Requires: clean_rawdata plugin (EEGLAB 2024+ ships it by default).

report = struct('subject', {}, 'n_orig', {}, 'n_kept', {}, 'n_rejected', {});

for i = 1:length(ALLEEG)
    n_orig = ALLEEG(i).nbchan;

    ALLEEG(i) = clean_rawdata(ALLEEG(i), ...
        'FlatlineCriterion',  cfg.flatline_criterion, ...
        'ChannelCriterion',   cfg.chan_criterion, ...
        'LineNoiseCriterion', cfg.linenoise_criterion, ...
        'Highpass',           'off', ...    % already done in p1_highpass
        'BurstCriterion',     'off', ...    % ASR off
        'WindowCriterion',    'off', ...    % window rejection off
        'BurstRejection',     'off', ...
        'Distance',           'Euclidian');

    n_kept = ALLEEG(i).nbchan;
    n_rej  = n_orig - n_kept;

    report(i).subject    = ALLEEG(i).subject;
    report(i).n_orig     = n_orig;
    report(i).n_kept     = n_kept;
    report(i).n_rejected = n_rej;

    fprintf('[p1_channel_reject] Subject %s: kept %d/%d channels (%d rejected).\n', ...
        ALLEEG(i).subject, n_kept, n_orig, n_rej);

    if n_kept / n_orig < 0.80
        warning('[p1_channel_reject] Subject %s: less than 80%% channels retained -- inspect manually.', ...
            ALLEEG(i).subject);
    end
end
end
