package com.mvest.model;

import java.util.Hashtable;
import java.util.List;

public class Vo {
	protected List list;
	protected Hashtable outputTable;
	protected Hashtable inputTable;
	
	int totalPage;
	int firstPage;
	int lastPage;
	int prevPage;
	int nextPage;
	int listItemNo;
	int totalRecord;
	int startRecord;
	int endRecord;
	int curPage;

	
	public void setList(List list){
		this.list =list;
	}
	public List getList(){
		return list;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getFirstPage() {
		return firstPage;
	}
	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}
	public int getLastPage() {
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	public int getPrevPage() {
		return prevPage;
	}
	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}
	public int getNextPage() {
		return nextPage;
	}
	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}
	public int getListItemNo() {
		return listItemNo;
	}
	public void setListItemNo(int listItemNo) {
		this.listItemNo = listItemNo;
	}
	public int getTotalRecord(){
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord){
		this.totalRecord = totalRecord;
	}
	public int getStartRecord() {
		return startRecord;
	}
	public void setStartRecord(int startRecord) {
		this.startRecord = startRecord;
	}
	public int getEndRecord() {
		return endRecord;
	}
	public void setEndRecord(int endRecord) {
		this.endRecord = endRecord;
	}
	public Hashtable getOutputTable() {
		return outputTable;
	}
	public void setOutputTable(Hashtable outputTable) {
		this.outputTable = outputTable;
	}
	public Hashtable getInputTable() {
		return inputTable;
	}
	public void setInputTable(Hashtable inputTable) {
		this.inputTable = inputTable;
	
	}
	public void setCurPage(int curPage){
		this.curPage = curPage;
	}
	public int getCurPage(){
		return curPage;
	}
	
	
	
	
	@Override
	public String toString() {
		return "Vo [list=" + list + ", totalPage=" + totalPage + ", firstPage=" + firstPage + ", lastPage=" + lastPage
				+ ", prevPage=" + prevPage + ", nextPage=" + nextPage + ", listItemNo=" + listItemNo + ", totalRecord="
				+ totalRecord + ", startRecord=" + startRecord + ", endRecord=" + endRecord + "]";
	}
	
	
}
