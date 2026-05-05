function ALLEEG = p1_highpass(ALLEEG, cfg)
% Apply a zero-phase FIR highpass filter to each dataset in ALLEEG.
%
% Uses pop_eegfiltnew (EEGLAB's built-in wrapper around firfilt).
% Cutoff: cfg.highpass_hz (default 1 Hz).
% 1 Hz removes slow DC drift without distorting the 0-500 ms epoch window.
% Filter order is set automatically by pop_eegfiltnew based on cutoff and srate.
%
% Requires: EEGLAB 2024+.

for i = 1:length(ALLEEG)
    ALLEEG(i) = pop_eegfiltnew(ALLEEG(i), cfg.highpass_hz, []);
    fprintf('[p1_highpass] Subject %s: highpass %.1f Hz applied.\n', ...
        ALLEEG(i).subject, cfg.highpass_hz);
end
end
