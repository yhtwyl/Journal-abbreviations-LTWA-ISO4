% function abbreviationISO4(string,LTWAISO4Abbreviations)
% disp(size(LTWAISO4Abbreviations));
string = "Journal of Liquid Chromatography and Related Technologies"; % SAMPLE JOURNAL NAME
splitted = split(string);
% length(splitted(1));
for i = 1:length(splitted)
    count = 0;
    while true
        query_str = splitted(i).extractBefore(strlength(splitted(i)) - count + 1);
        idx = strncmpi(LTWAISO4Abbreviations{:,"Column1"},query_str,strlength(query_str));
        if strlength(query_str) <= 4
            fprintf("%s. ",query_str);
            break;
        elseif nnz(idx)
            if nnz(idx) > 1
                indices = find(idx);
                [~,v] = sort(LTWAISO4Abbreviations{indices,"Column1"}.strlength);
                if (LTWAISO4Abbreviations{indices(v(1)),"Column1"}.strlength == strlength(query_str))
                    fprintf("%s ",LTWAISO4Abbreviations{indices(v(1)),"Column2"});
                    break;
                elseif ((nnz(idx) == 1) && (LTWAISO4Abbreviations{idx,"Column1"}.strlength ~= strlength(query_str)) && LTWAISO4Abbreviations{idx,"Column1"}.endsWith('-'))
                    fprintf("%s ",LTWAISO4Abbreviations{idx,"Column2"});
                    break;
                else
                    count = count + 1;
                end
%                fprintf("%s\n",LTWAISO4Abbreviations{indices(v(1)),"ABBREVIATIONS"});
%                 break;
            elseif (nnz(idx) == 1) && (LTWAISO4Abbreviations{idx,"Column1"}.strlength == strlength(query_str))
                fprintf("%s ",LTWAISO4Abbreviations{idx,"Column2"});
                break;
            elseif ((nnz(idx) == 1) && (LTWAISO4Abbreviations{idx,"Column1"}.strlength ~= strlength(query_str)) && LTWAISO4Abbreviations{idx,"Column1"}.endsWith('-'))
                fprintf("%s ",LTWAISO4Abbreviations{idx,"Column2"});
                break;
            end
        else
            count = count + 1;
        end
    end
end
fprintf("\n");
% end