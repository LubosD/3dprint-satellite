$fn=100;
angle=68;
thickness=1.5;
rtop=29;

function cyl_height(top_r, bottom_r) = tan(90-angle) * (bottom_r - top_r);

module cover(top_r, bottom_r) {
    height = cyl_height(top_r, bottom_r);
    
    cylinder(h=height, r2=top_r, r1=bottom_r, center=true);
}

module everything() {
    w = 119;
    translate([0, 0, cyl_height(rtop, w)/2])
    difference() {
        cover(29+thickness, w+thickness);
        cover(29, w);
    }

    translate([0, 0, cyl_height(rtop, w)+5])
    difference() {
        union() {
            cylinder(h=10, r1=rtop+thickness, r2=rtop+thickness, center=true);
            cube([(rtop+thickness)*2+24, 5, 10], center=true);
        };
        cylinder(h=10, r1=rtop, r2=rtop, center=true);
        
        for(x = [-36,36])
        rotate([90,0,0])
            translate([x,0,0])
            cylinder(h=10, r1=4.5/2, r2=4.5/2, center=true);
    };
    
    // rim
    difference() {
        cylinder(h=1.5, r1=w+thickness, r2=w+thickness);
        cylinder(h=1.5, r1=w-thickness*2, r2=w-thickness*2);
    }
    
    for(zrot = [0,180,270])
        rotate([0,0,zrot])
        translate([rtop, -5/2, cyl_height(rtop, w+thickness)])
        rotate([0, 1*(90-angle), 0])
        slant_edge(w+thickness);
}

difference() {
    everything();
    
    translate([-150,0,0])
        cube([300, 300, 300]);

}

module slant_edge(width) {
    w = width - rtop;
    h = cyl_height(rtop, width);
    
    len = sqrt(w*w + h*h);
    
    cube([len, 5, 3]);
}

