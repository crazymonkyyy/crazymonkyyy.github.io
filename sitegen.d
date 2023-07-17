#!/usr/bin/env rdmd
enum siteconfig="config";
import std;
void main(){
	foreach(s;File(siteconfig).byLineCopy){
		executeShell("rm "~s~".html");
		auto o=File(s~".html","w");
		//executeShell("cat header.html "~s~" footer.html > "~s~".html");
		foreach(t;File("header.html").byLineCopy){
			o.writeln(t);
		}
		foreach(t;File(s).byLineCopy){
			if(t==""){
				o.writeln("<p>");
			} else {
				o.writeln(t);
			}
		}
		foreach(t;File("footer.html").byLineCopy){
			o.writeln(t);
		}
	}
	//executeShell("python -m http.server");
}