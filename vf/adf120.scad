include <shapes.scad>

$fn=300;

F_D_RATIO = 0.32;

module ring(d) {
    // height: 12.5
    // inner depth: 6.4
    
    difference() {
        cylinder(h=12.5, d=d);
        translate([0,0,12.5-6.4])
            cylinder(h=6.4, d=d-2);
        
        // waveguide hole
        cylinder(h=6.4, d=18.75);
    }
}

module rings() {
    ring(70);
    ring(58);
    ring(47);
    ring(35.5);
    ring(24);
}

// Data source:
// http://restoradish.blogspot.com/2014/05/matching-feedhorn-to-faster-dish.html
function protrusion(fd) = lookup(fd, [
    [ 0.43, 0 ],
    [ 0.42, 1 ],
    [ 0.395, 3 ],
    [ 0.38, 4 ],
    [ 0.35, 5 ],
    [ 0.32, 6 ],
]);

c120();

//waveguide
translate([0,0,4])
difference() {
    cylinder(h=60, d=25.4);
    
    cylinder(h=60, d=0.74*25.4);
}

// rings
translate([0, 0, 60-9-protrusion(F_D_RATIO)])
rings();
