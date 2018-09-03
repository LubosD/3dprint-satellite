$fn=300;

// C120 flange
// 0.74"
// Measurements taken from ADF-120
module c120() {
    difference() {
        // plate
        cylinder(h=4, d=49.75);
        
        // waveguide hole
        cylinder(h=4, d=18.75);
        
        // 4x M4 bolt holes
        for (zrot=[0,90,180,270]) {
            rotate([0,0,zrot])
            translate([39.45/2,0,0])
            cylinder(h=4, d=4.1);
        }
    }
}

// WR75 flange
// 0.75" by 0.375"
// Measurements from smw.se and microtech.com
module wr75() {
    difference() {
        translate([0,0,2])
        cube([39,39,4], center=true);
        
        // 4x M4 bolt holes
        for (zrot=[0,90,180,270]) {
            rotate([0,0,zrot])
            translate([0.52*25.4, 0.561*25.4,0])
            cylinder(h=4, d=4);
        }
        
        translate([0,0,2])
        cube([0.75*25.4, 0.375*25.4, 4], center=true);
    }
}

c120();
//wr75();
