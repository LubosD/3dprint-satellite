/*
T90 LNB holder (c) by Lubos Dolezel

T90 LNB holder is licensed under a
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.

You should have received a copy of the license along with this
work. If not, see <http://creativecommons.org/licenses/by-nc-sa/4.0/>.
*/

$fn=150;
// for M5 screw nuts
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

module cylinder_mid(height,radius,fn){
   fudge = (1+1/cos(180/fn))/2;
   cylinder(h=height,r=radius*fudge,$fn=fn);}
   
   module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);}

module mainTube() {
    difference() {
        union() {
            cylinder(h=66, r1=31.5/2, r2=31.5/2);
            
            // flat surface under screw top
            for(y=[14.5, -14.5])
                translate([0, y, 76 - 25 - 13])
                    rotate([90,0,0])
                    cylinder(h=3, r1=6, r2=6, center=true);
        }
        
        // screw hole
        translate([0, 0, 76 - 25 - 13])
            rotate([90,0,0])
            cylinder(h=32, r1=3, r2=3, center=true);    
    }
    
}


module holderToTube() {
    /*
    points = [
        [-31.5/2,16.75,0],
        [31.5/2,16.75,0],
        [46,95, 0],
        [-46, 95, 0],
        
        [-31.5/2,0,24],
        [31.5/2,0,24],
        [46,95, 24],
        [-46, 95, 24],
    ];*/

    points = [
        [-31.5/2,33,0],
        [31.5/2,33,0],
        [25.5,75, 0],
        [-25.5, 75, 0],
        
        [-31.5/2,16.75,24],
        [31.5/2,16.75,24],
        [25.5,75, 24],
        [-25.5, 75, 24],
    ];
    /*
    faces = [
        [0,1,2,3],  // bottom
        [4,5,1,0],  // front
        [7,6,5,4],  // top
        [5,6,2,1],  // right
        [6,7,3,2],  // back
        [7,4,0,3], // left
    ];*/
    
    faces = [
        [0,1,2,3],  // bottom
        [4,5,1,0],  // front
        [7,6,5,4],  // top
        [5,6,1], [6,2,1],  // right
        [6,7,3,2],  // back
        [7,4,0],[3,7,0] // left
    ];
    
    polyhedron(points, faces);
}


// tloustka objimky 12mm
module lnbHolder() {
    translate([0,0,95-31.5-1])
    rotate([0,90,0])
    union() {
        difference() {
            union() {
                cylinder(h=24, r1=40/2+12, r2=40/2+12);
                
                translate([95,0,0])
                rotate([0,0,90])
                    holderToTube();
                
                // top screw solid area
                translate([-28,0,12])
                rotate([90, 0, 0])
                    cylinder(h=31.5, r1=9, r2=9, center=true);
            }

            cylinder(h=24, r1=40/2, r2=40/2);
            
            translate([40,0,12])
                rotate([90,0,0])
                cylinder(h=60, r1=3, r2=3, center=true);
            
            translate([40,23,12])
            rotate([90,0,0])
                hexagon(10, 18);
            
            translate([40,-17,12])
            rotate([90,0,0])
                cylinder(h=10, r1=6, r2=6);
            
            // top screw hole
            translate([-28,0,12])
            rotate([90, 0, 0])
                cylinder(h=80, r1=3, r2=3, center=true);
            
            translate([-28,25.5,12])
            rotate([90, 0, 0])
                hexagon(10, 20);
                
            translate([-28,-25.5,12])
            rotate([90, 0, 0])
                cylinder(h=20, r1=6, r2=6, center=true);
        };
    
    };
}

module wholeBody() {
    difference() {
        union() {
            rotate([0, 90, 0])
                mainTube();

            //translate([10,0,0])
            rotate([0,-35,0])
                lnbHolder();
        };
        
        // hollow inside
        rotate([0, 90, 0])
            //cylinder(h=77, r1=25/2, r2=25/2);
            cylinder_outer(77, 25/2, 80);
    }
}

// first half
rotate([-90,0,0])
difference() {
    wholeBody();
    
    translate([-80,0,-20])
        cube([200, 74, 150]);
};


// second half
rotate([90,0,0])
difference() {
    wholeBody();
    
    translate([-80,-74,-20])
        cube([200, 74, 150]);
};

