/*
T90 LNB holder (c) by Lubos Dolezel

T90 LNB holder is licensed under a
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.

You should have received a copy of the license along with this
work. If not, see <http://creativecommons.org/licenses/by-nc-sa/4.0/>.
*/

use <Triangles.scad>;

// May need to be increased to 2.5 for soft filaments
screw_r = 2;
$fn = 20;


module t90_pin() {
    difference() {
        union() {
            cylinder(h=14, r1=3.9, r2=3.9, center=false);
            translate([0, 0, 16.3])
            rotate([180,0,0])
                    linear_extrude(height=3, center=false, scale=[1.40,0.95])
                        circle(r=3.9);
        }
        
            translate([-2.4,-5,17])
rotate([90,180,180])
Triangle(8, 2.5, angle=90, height=10);
    
    translate([2.4,5,17])
rotate([90,180,0])
Triangle(8, 2.5, angle=90, height=10);
        
        /*
        translate([-2.5, -6, 10])
            cube([5, 12, 8], center=false);
        */

    }
    


}

module t90_top() {
    difference() {
        union() {
            // main body
            cylinder(h=15, r1=29, r2=29, $fn=80);
            
            // where the screw is
            translate([-5, -29-5.5, 0])
                cube([5, 15, 15]);
        };
        
        cylinder(h=15, r1=40/2, r2=40/2, $fn=80);
        translate([0, -29, 0])
            cube([29, 29*2, 15]);
        
        // screw hole
        translate([-10, -29, 15/2])
            rotate([0, 90, 0])
            cylinder(h=20, r1=2.5, r2=2.5);
        
        // screw cap hole
        translate([-15, -29, 15/2])
            rotate([0, 90, 0])
            cylinder(h=10, r1=4.5, r2=4.5);
    }
    
    // turning point
    difference() {
        //translate([-4, 25, 3])
        //    cube([10, 7, 8]);
        translate([2.5, 28, 2.5])
            cylinder(h=10, r1=3, r2=3);
        
        translate([2.5, 28, 2.5])
            cylinder(h=10, r1=1.55, r2=1.55);
        
        translate([2.5, 29, 2.5])
            rotate([0, 0, -130])
            Triangle(5, 5, angle=70, height=10);
        
    };
    
}

module t90_bottom() {

    // Slanted edge
    translate([37, 49, 0])
    rotate([-90,180,180])
        Triangle(15, 6, angle=90, height=49);

    // Main body
    difference() {
        cube([37, 49, 15]);
        translate([0, 49/2, 0])
        cylinder(h=15, r1=40/2, r2=40/2, $fn = 80);

        // label
        translate([29, 49/2, 14])
            rotate([0, 0, 90])
            linear_extrude(height=1)
                    text(text="T90", size=3, halign="center");
    }

    // Pin attaching the main body to the slider
    translate([37+3, 49/2, 15/2])
        rotate([0, 68.199, 0])
        rotate([0, 0, 90])
        t90_pin();

    // screw hole
    difference() {
        union() {
            translate([0, -10, 0])
                cube([10, 10, 15]);
            
            translate([5, -8, 0])
            cylinder(r1=5, r2=5, h=15);
            
            /*
            translate([10, 0, 15])
                rotate([180,0,0])
                Triangle(10, 10, angle=90, height=3);
            
            translate([10, 0, 3])
                rotate([180,0,0])
                Triangle(10, 10, angle=90, height=3);
            */
        };
            
        rotate([0, 90, 0])
            translate([-15/2, -5, 0])
            cylinder(h=11, r1 = screw_r, r2 = screw_r);
    }

    // turning point
    union() {
        translate([1.5+1, 49+1.5+2, 0])
            cylinder(h=15, r1=1.5, r2=1.5);
        
        for(z = [15 - 2, 0])
            translate([0, 49, z])
                cube([4, 4, 2]);
    }
}

/*translate([-10, 29-4.5, 0])
    t90_top();*/

t90_bottom();
