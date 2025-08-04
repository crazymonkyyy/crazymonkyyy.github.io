#!/usr/bin/env -S sh -c 'dmd -run projectgen.d > projects'
import std;
enum string[] list=[
"https://github.com/crazymonkyyy/frut_gam3",
"https://github.com/crazymonkyyy/snake",
"https://github.com/crazymonkyyy/text-paint",
"https://github.com/crazymonkyyy/lazyinfographic",
"https://github.com/crazymonkyyy/dingbats",
"https://github.com/crazymonkyyy/blackmagic-in-d/",
];
int hash(string s) {
  int result = 0;
  foreach (c; s)
    result = result * 31 + c;

  return result;
}
//https://raw.githubusercontent.com/crazymonkyyy/text-paint/master/README.md
//https://github.com/crazymonkyyy/text-paint
string urltomarkdown(string s){
	enum head="https://github.com/";
	enum newhead="https://raw.githubusercontent.com/";
	if(s[0..head.length]==head){
		s=s[head.length..$];
		s=newhead~s;
	}
	s~="/master/README.md";
	return s;
}
unittest{
	foreach(url;list){
		urltomarkdown(url).writeln;
	}
}
string removehashtags(string s){
	while(s[0]=='#'){s=s[1..$];}
	return s;
}
unittest{
	"###hashtag".removehashtags.writeln;
}
string markdowntoimage(string s){
	s=s[s.indexOf('(')+1..$-1];
	return s;
}
unittest{
	"![keybinds](lazyinfo.png)".markdowntoimage.writeln;
}
//https://github.com/crazymonkyyy/lazyinfographic
//https://github.com/crazymonkyyy/lazyinfographic/blob/master/lazyinfo.png
string imagetourl(string img,string url){
	enum tail="/blob/master/";
	return url~tail~img~"?raw=true";//wtf github
}
unittest{
	imagetourl("lazyinfo.png","https://github.com/crazymonkyyy/lazyinfographic").writeln;
}
void download(string url,string dst){//wget should be better then this
	string command="[ ! -f \""~dst~"\" ] &&"~
		" wget "~url~" -O "~dst;
	//command.writeln;
	executeShell(command);
}
void main(){
	string[] alignment=["left","right"];
	foreach(alig,url;zip(alignment.cycle,list)){
		"<div class=\"proj-div\">".writeln;
		string h="temp/"~hash(url).to!string;
		string md=urltomarkdown(url);
		download(md,h);
		bool headerfound,imagefound=false;
		string[] o;
		foreach(s;File(h).byLineCopy){
		if(!headerfound|!imagefound){
			if(s==""){o~="<p>"; continue;}
			if(s[0]=='#'){
				if(headerfound){break;}
				o~="<h1>";
				o~=("<a href="~url~">");
				o~=s.removehashtags;
				o~="</a>";
				o~="</h1>";
				headerfound=true;
				continue;
			}
			if(s[0]=='!'){
				imagefound=true;
				string img=markdowntoimage(s);
				download(
					imagetourl(img,url),
					"images/"~img);
				img="images/"~img;
				("<img class=\"project\" src=\""~img~"\" align=\""~alig~"\"/>").writeln;
				continue;
			}
			o~=s;
		}}
		foreach(s;o){
			s.writeln;
		}
		"</div><hr>".writeln;
	}
}
