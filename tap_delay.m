function [output] = tap_delay(sound, depth, delta, gain, fs)

    % Daniel Zuerbig
    % homework 4 tap delay

    if delta < .0001
        delta = .0001;
    elseif delta > 8
        delta = 8;
    end
    if gain > .99
        gain = .99; % to prevent infinite oscillation
    end
    % minimum error correction
    
    N = floor(delta * fs);
    y = zeros(N + 3*length(sound),2); % large preallocation for long decay
    l = N + 1;
    
    value = 1;
    while value > .05 % stops running when tail power is small enough
        
        if (l - N) < length(sound)
            y(l,:) = gain*y(l - N,:) + sound(l - N,:); % feedback loop
        else
            y(l,:) = gain*y(l - N,:);
            value = sum(abs(y(l-100:l,1))); % checking tail power
        end
        if l >= length(y) % if run out of preallocated space
            break
        end
        l = l + 1;
    end
    
    y = y * depth; % output of feedback and delay loop
    
    output = y;
    output(1:length(sound),:) = output(1:length(sound),:) + sound;
    % adding back in sound
    
    
    output = output./max(abs(output)); % normalize output
    
    ind = find(output(:,1) > .0001);
    output = output(1:ind(end),:);
    % remove trailing zeros introduced from preallocation
    
end

