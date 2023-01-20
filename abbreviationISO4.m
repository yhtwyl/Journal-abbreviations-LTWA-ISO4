% function abbreviationISO4(string,ltwa20210702)
% disp(size(ltwa20210702));
%% This program follows the abbeviations provided in the LTWA ISO4 Abbreviations (https://www.issn.org/services/online-services/access-to-the-ltwa/) to create the abbreviated journal titles
%% Import the file and then run the program.
%% Author Manoj Dhiman
%% Date : 21/01/23
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
string = "Journal of Liquid Chromatography and Related Technologies"; % SAMPLE JOURNAL NAME
splitted = split(string);
% length(splitted(1));
for i = 1:length(splitted)
    count = 0;
    while true
        query_str = splitted(i).extractBefore(strlength(splitted(i)) - count + 1);
        idx = strncmpi(ltwa20210702{:,"WORDS"},query_str,strlength(query_str));
        if strlength(query_str) <= 4
            fprintf("%s. ",query_str);
            break;
        elseif nnz(idx)
            if nnz(idx) > 1
                indices = find(idx);
                [~,v] = sort(ltwa20210702{indices,"WORDS"}.strlength);
                if (ltwa20210702{indices(v(1)),"WORDS"}.strlength == strlength(query_str))
                    fprintf("%s ",ltwa20210702{indices(v(1)),"ABBREVIATIONS"});
                    break;
                elseif ((nnz(idx) == 1) && (ltwa20210702{idx,"WORDS"}.strlength ~= strlength(query_str)) && ltwa20210702{idx,"WORDS"}.endsWith('-'))
                    fprintf("%s ",ltwa20210702{idx,"ABBREVIATIONS"});
                    break;
                else
                    count = count + 1;
                end
%                fprintf("%s\n",ltwa20210702{indices(v(1)),"ABBREVIATIONS"});
%                 break;
            elseif (nnz(idx) == 1) && (ltwa20210702{idx,"WORDS"}.strlength == strlength(query_str))
                fprintf("%s ",ltwa20210702{idx,"ABBREVIATIONS"});
                break;
            elseif ((nnz(idx) == 1) && (ltwa20210702{idx,"WORDS"}.strlength ~= strlength(query_str)) && ltwa20210702{idx,"WORDS"}.endsWith('-'))
                fprintf("%s ",ltwa20210702{idx,"ABBREVIATIONS"});
                break;
            end
        else
            count = count + 1;
        end
    end
end
fprintf("\n");
% end