$fn=40;

cylinder(h=1, r1=5, r2=5);

translate([0,0,4])
    cube([1, 4, 7], center=true);
    
translate([1.3,0,4])
rotate([0, -10, 0])
    cube([1, 4, 7], center=true);
    
translate([-1.3,0,4])
rotate([0, 10, 0])
    cube([1, 4, 7], center=true);

translate([0,0,7])
cylinder(h=1.5, r1=2.5, r2=2.5);
