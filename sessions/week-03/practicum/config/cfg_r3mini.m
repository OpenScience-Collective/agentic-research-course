function cfg = cfg_r3mini()
% Configuration for HBN R3-mini (100 Hz, 20 subjects, development run).
% Switch to cfg_r3full.m once the pipeline validates end-to-end on mini.

% Data paths -- update bids_root to your local R3-mini copy.
% Download: aws s3 sync s3://fcp-indi/data/Projects/HBN/BIDS_EEG/cmi_bids_R3 \
%           <bids_root> --exclude "*" --include "sub-NDAR*/ses-HBNsite*/eeg/*ThePresent*"
% (Select 20 subjects from participants.tsv with EEG availability flag = 1.)
cfg.bids_root  = fullfile(getenv('HOME'), 'data', 'HBN', 'R3-mini');
cfg.deriv_root = fullfile(fileparts(mfilename('fullpath')), '..', '..', '..', 'derivatives');

% Task
cfg.task       = 'ThePresent';

% Sampling rate -- R3-mini is already downsampled to 100 Hz.
% Full R3 is 500 Hz; resample before this pipeline if using full data.
cfg.srate      = 100;

% Preprocessing parameters
cfg.highpass_hz   = 1;          % Hz; FIR highpass via pop_eegfiltnew
cfg.cleanline_hz  = [60 120 180]; % US line noise harmonics; adjust for 50 Hz countries

% clean_rawdata channel rejection thresholds (ASR and window rejection off).
% ChannelCriterion: correlation with neighboring channels (0.85 is conservative).
% FlatlineCriterion: max flat-line duration in seconds before channel is dropped.
% LineNoiseCriterion: max line-noise Z-score (applied after CleanLine; catches residual).
cfg.chan_criterion      = 0.85;
cfg.flatline_criterion  = 5;
cfg.linenoise_criterion = 4;

% subjects: cell array of subject IDs to process, or {} to use all found in bids_root.
% Explicit list is preferred for reproducibility on R3-mini.
cfg.subjects = {};
