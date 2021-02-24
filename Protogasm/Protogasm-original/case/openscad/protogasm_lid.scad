//  ----------------------------------------------------------------------- LICENSE
//  This "3D Printed Case for Arduino Uno, Leonardo" by Zygmunt Wojcik is licensed
//  under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
//  To view a copy of this license, visit
//  http://creativecommons.org/licenses/by-sa/3.0/
//  or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.


//------------------------------------------------------------------------- SHARED PARAMETERS
$fn=100; // resolution

circleD = 21; // round corner circle diameter
roundR = circleD/2; // round corner circle radius
triangleH = (sqrt(3)*(circleD))/2; // triangle height to calculate other variables

layerHeight = 0.25; // some variariables are multiple of layer height and width
layerWidth = 0.5;

screwExt = 3.4; // screw through hole diameter
verConnectionHoleR = 1.2; // screw thread hole radius
screwHead = 6; // screw head hole diameter

gap = layerHeight/2;

floorHeight = 1.8; // 6*0.25 layer + 0.3 first layer

height = 20.6; // case height
innerHeight = height - floorHeight*2;

pillarSize = roundR-0.01; // corner pillar size

// dimensions of minkowski's inner square
// these are NOT case dimensions
// to calculate external case dimesions add 2 * roundR
// 55.3 + (2*10.5) = 76.3
width = 55.3;
wide = 55.3;

blockLockSize = 2; // middle connection lock size

// side cutting panels size
sidePanelXWidth = wide;
sidePanelYWidth = width;

// screw hole position from centre of the corner round circle
screwHoleRoundR = roundR - layerWidth*4 - (triangleH/2 - layerWidth*4)/2;

// prints dimensions of the case
echo("width", width + roundR*2); // total width
echo("wide", wide + roundR*2); // total wide

// UNO PCB dimensions
pcbWide=53.3;
pcbLenght=68.58;
pcbHeight=1.64;
usbHolePosition=38.1;
usbHeight=10.8 + 2;
usbWide=11.43 + 2;
powerJackPosition=7.62;
powerJackWide=8.9 +2;
powerJackHeight=10.8 +2;

pcbPositionX = width/2 + roundR - layerWidth*7 - gap*4;
pcbPositionZ = 2.5;

extra_headroom = 9.36;

knob_position = [-1.27,0,0];

//------------------------------------------------------------------------- MAIN BLOCK
difference()
{
																		// ADD
	union()
	{
		// Add Base
		linear_extrude(height = height/2 + blockLockSize + extra_headroom, convexity = 10)
		minkowski()
		{									
			square([width, wide], center = true);
			circle(roundR);
		}
	}
																		// SUBSTRACT
	union()
	{
		// lift floor height
		translate([0, 0, floorHeight])
		{
			// Cut base inner hole
			linear_extrude(height = height + extra_headroom, convexity = 10)
			minkowski()
			{
				square([width, wide], center = true);
				circle(roundR - pillarSize);
			}
			// Cut block lock
			translate([0, 0, height/2 - blockLockSize + extra_headroom])
			linear_extrude(height = height + extra_headroom, convexity = 10)
			minkowski()
			{
				square([width, wide], center = true);
				circle(roundR - layerWidth*3);
			}
			// Cut x panels 
			for (i = [0 : 180 : 180])				
			rotate([0, 0, i])
			translate([width/2 + roundR - pillarSize/2 - layerWidth*7, 0, 0])
			{
				// Cut X panel hole
				translate([0, 0, (height+extra_headroom)/2 ])
				cube([pillarSize, sidePanelXWidth, height + extra_headroom], center=true);

				// Cut X, Y srew holes
				for (i = [wide/2, -wide/2])
				{
					translate([-(roundR - pillarSize/2 - layerWidth*7), i, 0])
					if (i>0) 
					{
						rotate([0, 0, 45])
						translate([screwHoleRoundR, 0, 0])
						cylinder(h=height/2 + extra_headroom, r=verConnectionHoleR);
					}
					else
					{
						rotate([0, 0, -45])
						translate([screwHoleRoundR, 0, 0])
						cylinder(h=height/2 + extra_headroom, r=verConnectionHoleR);
					}
				}
			}
			// Cut Y panels 
			for (i = [90 : 180 : 270])
			rotate([0, 0, i])
			translate([wide/2 + roundR - pillarSize/2 - layerWidth*7, 0, 0])
			{
				// Cut Y panel hole
				translate([0, 0, (height+extra_headroom)/2])
				cube([pillarSize, sidePanelYWidth, height+extra_headroom], center=true);
			}
			
            // Cut USB and Power holes
			// Rotate due to panel upside down
			mirror([0, 1 , 0])
            
			// translate to pcb position
			translate([-pcbPositionX, -pcbWide/2, height - pcbPositionZ -pcbHeight - 4 + extra_headroom])
			{
				// Cut power hole
				translate([0, powerJackPosition+10, -(powerJackHeight-2)/2])
				cube([10, powerJackWide+20, powerJackHeight], center=true);
				// Cut usb hole
				translate([0, usbHolePosition, -(usbHeight-2)/2])
				cube([10, usbWide, usbHeight], center=true);
				
			}
		}
		//Knob hole
		translate(knob_position)
		cylinder(h=20, r = 8/2, center=true);

	}
}

difference() {
	// Knob boss
	translate(knob_position)
	cylinder(h = floorHeight + 2, r=12/2);

		//Knob hole
		translate(knob_position)
		cylinder(h=20, r = 8/2, center=true);

}