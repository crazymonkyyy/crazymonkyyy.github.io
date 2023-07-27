#!/usr/bin/env -S sh -c 'dmd -run gradient.d | convert -size 255x255 -depth 8 rgb:- output.gif'
const width=255;//defining some constants
const height=255;
import std;
void main(){
	foreach(ubyte time;0..255){// Im making it 255 frames long
	foreach(ubyte y;0..height){// inverse order so x finishes before y
	foreach(ubyte x;0..width){
		ubyte r=time;//a ubyte is a number between 0-255
		ubyte g=y;
		ubyte b=x;
		ubyte[3] pixel=[r,g,b];// pixels come in chunks of 3 ubytes
		stdout.rawWrite(pixel);// rawWrite is for binary data, while stdout expects a kind of plain text
	}}}
}