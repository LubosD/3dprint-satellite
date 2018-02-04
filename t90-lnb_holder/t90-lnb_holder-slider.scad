/*
T90 LNB holder (c) by Lubos Dolezel

T90 LNB holder is licensed under a
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.

You should have received a copy of the license along with this
work. If not, see <http://creativecommons.org/licenses/by-nc-sa/4.0/>.
*/

module roundedRect(size, radius) {
    x = size[0];
    y = size[1];
    
    hull() {
        // place 4 circles in the corners, with the given radius
    translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
    circle(r=radius);

    translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
    circle(r=radius);

    translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
    circle(r=radius);

    translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
    circle(r=radius);
    }
}

module angleNumber(number) {
    rotate([90, 180, 0])
            rotate([0, 0, -90])
            linear_extrude(height=1)
            text(text=number, size=3, halign="center");
}

$fn = 20;

module railHolderMainBody() {

    // Bottom
    linear_extrude(height = 19, center=true)
        difference() {
            square([35, 45], true);
            // Main etch
            translate([-6, -8]) square([12, 32]);
            // Wider top
            translate([0, -6]) roundedRect([15, 8], 1);
            
            // Right side of the rail
            translate([7, 5.7]) roundedRect([6, 16], 1);
            translate([7+0.5, 12]) square([3, 5]);
            
            // Left side of the rail
            translate([-7, 5.7]) roundedRect([6, 16], 1);
            translate([-7-3.5, 12]) square([3, 5]);
        };
        

    // Top table
    translate([0, -22, 0])
    difference() {
        rotate([90, 0, 0])
            rotate([0, 0, 90])
            cube([50, 36, 3], center=true);
        
        // Four decorative notches
        for (x = [-17, 17])
            for (z = [-11, 11])
                translate([x, 0, z])
                    cube([3,3,3], center=true);
        
        // 0 deg. line
        translate([-6, -1.5, 0])
            cube([0.5, 0.5, 40], center=true);
        
        for (z = [-22, 22])
            translate([-4.5, -1, z])
            angleNumber("0");
            
        // 10 deg. line (which is actually 5 deg.)
        for (y = [5, -5])
            translate([-6, -1.5, 0])
            rotate([0, y, 0])
                cube([0.5, 0.5, 50], center=true);
        
        for (z = [-20, 20])
            translate([-9, -1, z])
            angleNumber("10");

        // 20 deg. line
        for (y = [20, -20])
            translate([-6, -1.5, 0])
            rotate([0, y, 0])
                cube([0.5, 0.5, 60], center=true);
        
        translate([-13, -1, -17])
            rotate([0, 20, 0])
            angleNumber("R20");
        translate([-13, -1, 17])
            rotate([0, -20, 0])
            angleNumber("L20");
    }
}

screw_r = 2;

rotate([90, 0, 0])
difference() {
    railHolderMainBody();
    
    // Screw against the rail
    translate([-14, 3.5, 0])
        rotate(a = [0,90,0])
        cylinder(h = 8, r1 = screw_r, r2 = screw_r, center = true);
    
    // Hole where the holder part turns
    translate([2.5, -16, 0])
        rotate(a = [90,0,0])
        cylinder(h=18, r1=4.25, r2=4.25, center = true);

    // Screw against holder part's pin
    translate([0, -15, 0])
        rotate(a = [0, 90, 0])
        cylinder(h=37, r1=screw_r, r2=screw_r, center = true);
    
    // Dent in the surface for the screw on one of the sides
    translate([-16, -15, 0])
    rotate([0, 90, 0])
    cylinder(h=3, r1=5, r2=5, center = true);
}


