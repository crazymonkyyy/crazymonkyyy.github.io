#!/usr/bin/env rdmd
enum siteconfig="config";
import std;
void main(){
	foreach(s;File(siteconfig).byLine){
		executeShell("rm "~s~".html");
		executeShell("cat header.html "~s~" footer.html > "~s~".html");
}}