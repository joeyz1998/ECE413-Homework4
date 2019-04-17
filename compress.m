function [output, gains] = compress(sound, thresh, slope, ave_l, fs)
    
    % Daniel Zuerbig
    % homework 4 compressor
    
    ave_sec = ave_l * 10^(-6); % length of accumulator
        
    N = floor(ave_sec * fs);
    
    l = length(sound);
    
    
    gains = zeros(1,l);
    output = zeros(l, 2); % memory allocation for gains
    
    test_t = 0:(1/fs):(ave_sec - 1/fs);
    test_y = sin(1000 * 2 * pi * test_t);
    thresh_norm = trapz((test_y).^2);
    % samples sin wave of same length as power accumulator, this is for
    % gain normalization
    
    
    for i = 1:l
        
        num = max(i-N, 1);
        pow = (1/thresh_norm) * trapz( (sound(num:i,1)).^2 );
        % power accumulation, normalized by amount of power of a 
        
        if pow < thresh % no change
            output(i,:) = sound(i,:);
            gains(i) = 1;
        else
            m = tan(slope * pi/8);
            gain = max(0, -m*(pow - thresh) + 1); % some math and mapping
            % want nominal gain to be one, and to slowly decrease it as the
            % input volume increases
            gains(i) = gain;
            output(i,:) = gain*sound(i,:);
        end

    end
    % output = output/max(output);
    % renormalize output, not really necessary
    
end

