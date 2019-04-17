function [output] = ring_mod(sound,freq,depth,fs)

    % Daniel Zuerbig
    % Homework 4 ring mod

    if depth < 0
        depth = 0;
    elseif depth > 1
        depth = 1;
    end
    
    l = length(sound);
    t = 0:1/fs:l/fs - 1/fs;
    
    mod = sin(2 * pi * freq * t); % ring modulation wave
    
    ring = mod' .* sound; % multiplication
    
    output = (depth * ring) + sound;
    
    
    output = output./max(abs(output));

end

