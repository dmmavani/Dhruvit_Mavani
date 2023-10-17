function O = struct2vec(Structure)
C = struct2cell(Structure);
O = [C{:}]';
end