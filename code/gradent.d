#!/usr/bin/env -S sh -c 'dmd -run gradient.d |
convert -size 255x255 -depth 8 rgb:- output.gif'
const width=255;
const height=255;
import std;
void main(){
	foreach(ubyte time;0..255){
	foreach(ubyte y;0..height){
	foreach(ubyte x;0..width){
		ubyte r=time;
		ubyte g=y;
		ubyte b=x;
		ubyte[3] pixel=[r,g,b];
		stdout.rawWrite(pixel);
	}}}
}