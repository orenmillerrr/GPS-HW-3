function [corr,shift] = cxcorr(seq1,seq2,type)

    if nargin < 2 
        seq2 = seq1;
    elseif isempty(seq2)
        seq2 = seq1;
    end

    if nargin < 3
        type = "";
    end

    n = length(seq2);

    for i = -n+1 : n-1
        corr(i+n)=seq1*circshift(seq2,i)';
    end

    if type == "normalized"
        corr = corr/n;
    end
    
    shift = -n+1:n-1;
end

