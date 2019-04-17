function [output] = flanger(sound, depth, min_del, max_del, lfo, fs)
    
    % Daniel Zuerbig
    % Homework 4 flanger effect

    if min_del < .0001
        min_del = .0001;
    elseif min_del > .05
        min_del = .05;
    end
    if min_del > max_del
        temp = min_del;
        min_del = max_del;
        max_del = temp;
    end
    % minimum error correction and control flow
    
    N = floor(min_del * fs); % initial delay
    len = length(sound);
    
    output = zeros(N + length(sound),2); % preallocate memory
    
    t = 0:1/(fs):1/fs*(len-N-1);
    %sweep = (max_del - min_del)*.5*sin(2 * pi * lfo * t) + (max_del+min_del)/2;
    sweep = (max_del - min_del)*.5*sawtooth(2 * pi * lfo * t,.2) + (max_del+min_del)/2;
    % I like this asymetrical sawtooth pattern
    
    for l = 1:len-N
        
        N = floor(sweep(l)*fs); % N sweeps through delta t
        
        if N < l
            output(l,:) = depth*sound(l - N,:) + sound(l,:); % add in delayed value
        else
            output(l,:) = sound(l,:);
        end
        
    end
    
    
    %output(1:length(sound),:) = output(1:length(sound),:) + sound;
    
    output = output./max(abs(output)); % renormalize
end

