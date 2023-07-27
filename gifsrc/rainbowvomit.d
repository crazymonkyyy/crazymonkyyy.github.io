import std;
struct color{ubyte r,g,b;}
enum colors=[
color(255, 0, 0),
color(255, 63, 0),
color(255, 127, 0),
color(255, 191, 0),
color(255, 255, 0),
color(191, 255, 0),
color(127, 255, 0),
color(63, 255, 0),
color(0, 255, 0),
color(0, 255, 63),
color(0, 255, 127),
color(0, 255, 191),
color(0, 255, 255),
color(0, 191, 255),
color(0, 127, 255),
color(0, 63, 255),
color(0, 0, 255),
color(63, 0, 255),
color(127, 0, 255),
color(191, 0, 255),
color(255, 0, 255),
color(255, 0, 191),
color(255, 0, 127),
color(255, 0, 63),
color(255, 0, 0)];

int i;

enum white=cast(ubyte[3])([0, 43, 54]);
enum black=cast(ubyte[3])([253, 246, 227]);
void main(string[] s){
	ubyte[] data=cast(ubyte[])executeShell("convert "~s[1]~" rgb:-").output;
	foreach(t;0..100){
	foreach(pix;data.chunks(3)){
		if(pix==[255,0,0]){
			stdout.rawWrite(cast(ubyte[3])colors[(i++/5)%$]);
		} else {
			if(pix[0]>125){
				stdout.rawWrite(white);
			} else {
				stdout.rawWrite(black);
			}
		}
	}}
}