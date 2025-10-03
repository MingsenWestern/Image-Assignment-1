function boxes = find_bounding_boxes_34(im)

    [height, width] = size(im);
    visited = false(height, width);
    L = zeros(height, width, 'uint32');      % label matrix (0 = background)
    boxes = zeros(0, 4);            % will append rows as we find components

    % 4-connected neighbors: up, down, left, right
    neighbor = [-1  0;
                1  0;
                0 -1;
                0  1];

    currentLabel = uint32(0);

    % Preallocate a stack for worst case (H*W entries), store [row col]
    stack = zeros(height*width, 2, 'uint32');

    for row = 1:height
        for col = 1:width
            if im(row, col) && ~visited(row, col)
                % ---- Start a new component ----
                currentLabel = currentLabel + 1;

                % Seed bbox with the first pixel
                minRow = row; maxRow = row;
                minCol = col; maxCol = col;

                % Mark seed and push onto stack
                visited(row, col) = true;
                L(row, col) = currentLabel;

                pointer = 1;                         % next free slot (top+1)
                stack(pointer,1) = row;
                stack(pointer,2) = col; 
                pointer = pointer + 1;

                % ---- DFS loop ----
                while pointer > 1
                    pointer = pointer - 1;                % pop
                    currRow = stack(pointer,1);
                    currCol = stack(pointer,2);

                    % Explore 4 neighbors
                    for k = 1:4
                        newRow = currRow + neighbor(k,1);
                        newCol = currCol + neighbor(k,2);

                        if newRow >= 1 && newRow <= height && newCol >= 1 && newCol <= width ...
                           && im(newRow, newCol) && ~visited(newRow, newCol)

                            % Discover neighbor: mark visited + label
                            visited(newRow, newCol) = true;
                            L(newRow, newCol) = currentLabel;

                            % Update bbox
                            if newRow < minRow, minRow = newRow; end
                            if newRow > maxRow, maxRow = newRow; end
                            if newCol < minCol, minCol = newCol; end
                            if newCol > maxCol, maxCol = newCol; end

                            % Push neighbor
                            stack(pointer,1) = newRow; 
                            stack(pointer,2) = newCol; 
                            pointer = pointer + 1;
                        end
                    end
                end

                % Save bbox for this component
                boxes(end+1, :) = [minCol, minRow, maxCol - minCol, maxRow - minRow];
            end
        end
    end
end
