function [output] = distort(sound, gain, tone)
    
    % Daniel Zuerbig
    % homework 4 distortion effect
    
    
    dist = (256*sound.^9 + 384*sound.^8 - 704*sound.^7 - 928*sound.^6 + 720*sound.^5 + ...
        776*sound.^4 - 336*sound.^3 - 260*sound.^2 + 71*sound + 24);
    % adding harmonics with chebychev polynomials
    % from page 148 of Jerse book
    %dist = .8*sound.^5 + .8*sound.^4 - 1.8*sound.^3 - 1.6*sound.^2 + 1.15*sound + .5;
    %dist = dist * gain;
    
    %dist = sound;
    if (0 <= tone) && (tone <=1)
        cutoff = (.45)*tone + .05;
        [b, a] = butter(8, cutoff); % variable cuttoff lowpass filter
    else
        b = 1; a = 1; % the best filter is no filter
    end
    
    
    filt = filter(b, a, dist);
    
    output = (gain*filt/max(abs(filt))) + sound;
    output = output / max(abs(output));
    
    %output = output/max(abs(output)); % adding signal back in
    
    %output = output ./max(abs(output)); % normalizing to output
    
end

