package gongsakoker.helper.util;

/**
* 설명: 페이징처리
*
************************************************
* DATE          AUTHOR           DESCRIPTION
* ----------------------------------------------
* 2015.11.19    박정후     Initial Release
************************************************
*
*/


public class PageNavigator
{
	
	int currentPage;
    int rowsPerPage;
    int pagePerGroup;
    int startRow;
    int endRow;
    int totalSize;
    int pageTotal;
    int pageGroupStart;
    int pageGroupEnd;
    
	public PageNavigator(int j)
	{
	       pageTotal = 0;
	       // setCurrentPage(i);
	       setRowsPerPage(j);
	       setPagePerGroup(10);
	 }

    public PageNavigator(int i, int j)
    {
        pageTotal = 0;
        setCurrentPage(i);
        setRowsPerPage(j);
        setPagePerGroup(10);
    }

    public PageNavigator(int i, int j, int k)
    {
        pageTotal = 0;
        setCurrentPage(i);
        setRowsPerPage(j);
        setPagePerGroup(k);
    }

    public int getCurrentPage()
    {
        if(pageTotal > 0 && currentPage > pageTotal)
            currentPage = pageTotal;
        return currentPage;
    }

    public void setCurrentPage(int currentPage)
    {
        if(currentPage < 1)
            currentPage = 1;
        this.currentPage = currentPage;
        calcStartEndRow(currentPage);
    }

    public int getRowsPerPage()
    {
        return rowsPerPage;
    }

    public void setRowsPerPage(int rowsPerPage)
    {
        this.rowsPerPage = rowsPerPage;
        calcStartEndRow(currentPage);
    }

    public int getPagePerGroup()
    {
        return pagePerGroup;
    }

    public void setPagePerGroup(int pagePerGroup)
    {
        this.pagePerGroup = pagePerGroup;
        calcStartEndRow(currentPage);
    }

    public int getStartRow()
    {
        return startRow;
    }

    public int getEndRow()
    {
        return endRow;
    }

    private void calcStartEndRow(int currentPage)
    {
        //startRow = (currentPage - 1) * rowsPerPage + 1;
        //endRow = (startRow + rowsPerPage) - 1;
        
        startRow = rowsPerPage * currentPage - rowsPerPage;
        endRow = rowsPerPage;
    }

    public int getTotalSize()
    {
        return totalSize;
    }

    public void setTotalSize(int totalSize)
    {
        this.totalSize = totalSize;
        
        setPageTotal();
        setPageGroupStart();
        setPageGroupEnd();
    }

    public int getPageTotal()
    {
        return pageTotal;
    }

    public int getPageGroupStart()
    {
        return pageGroupStart;
    }

    public int getPageGroupEnd()
    {
        return pageGroupEnd;
    }

    public void setPageTotal()
    {
        int tempPageTotal = totalSize / rowsPerPage;
        if(totalSize > tempPageTotal * rowsPerPage)
            tempPageTotal++;
        pageTotal = tempPageTotal;
    }

    public void setPageGroupStart()
    {
        pageGroupStart = ((currentPage - 1) / pagePerGroup) * pagePerGroup + 1;
    }

    public void setPageGroupEnd()
    {
        int tempPageGroupEnd = getPageGroupStart() + pagePerGroup;
        if(tempPageGroupEnd > getPageTotal())
            tempPageGroupEnd = getPageTotal() + 1;
        if(tempPageGroupEnd > 1)
            tempPageGroupEnd--;
        pageGroupEnd = tempPageGroupEnd;
    }

    public void setPageGroupEnd(int totalPage)
    {
        pageGroupEnd = totalPage;
    }
    
}
