function [output] = trem(sound,LFO,freq,lag,depth,fs)
    
    % Daniel Zuerbig
    % homework 4 tremolo effect

    if freq < .05
        freq = .05;
    elseif freq > 5
        freq = 5;
    end
    if depth < 0
        depth = 0;
    elseif depth > 1
        depth = 1;
    end
    
    l = length(sound);
    t = 0:1/fs:l/fs - 1/fs;
    t_left = t + lag/1000;
    
    switch LFO
        case {'sin', 'sine'}
            osc_r = sin( 2 * pi * freq * t );
            osc_l = sin( 2 * pi * freq * t_left );
            % allowing for separate left and right tremolo
        case {'triangle', 'tri'}
            osc_r = sawtooth( 2 * pi * freq * t, .5 );
            osc_l = sawtooth( 2 * pi * freq * t_left, .5 );
        case {'square', 'sq'}
            osc_r = square( 2 * pi * freq * t );
            osc_l = square( 2 * pi * freq * t_left );
        otherwise
            error('invalid wave type specified')
    end
    
    osc = [osc_r;osc_l]';
    
    trem = .5*depth*osc + .5*depth + (1 - depth); % shifting depth so raised above 0
    
    output = sound .* trem;
    

end

