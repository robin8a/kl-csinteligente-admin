module ApplicationHelper
    def getParent(numberedListArray)
        result = ""
        for i in 0..numberedListArray.length - 2  do
            result = result + numberedListArray[i] + "."
        end
        return result.chomp(".")
    end 
end
