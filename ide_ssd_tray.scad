// 1.8" ZIF IDE to 3.5" tray
// Written by Michael Berry <michaelaberry@gmail.com>
model_version = "v1.0.0";

// Features: 
//  - ZIF to IDE Adapter mount
//  - Mount holes for 3.5" HDD
//  - Space for 1.8" ZIF IDE HDD/SDD

/*
TODO:
 - Add mounting holes to IDE board
 - Add proper lined holes to IDE board supports
*/
thickness = 3;

tray_x = 101;
tray_y = 150;
tray_z = 10;

offset_tray_x = tray_x / 2;
offset_tray_y = tray_y / 2;
offset_tray_z = tray_z / 2;

//Render the tray
difference() {
    color([0.9, 0.9, 0.9]) cube([tray_x, tray_y, tray_z], center = true);
    // Carve out the inner tray
    translate([0, thickness, thickness]) {
        cube([tray_x - 6, tray_y, tray_z], center = true);
    }

    // Carve out the mounting holes
    trayMount();
    mirror([tray_x, 0, 0]) trayMount();

    // Save some plastic!
    plasticSaverBase();
}

//Add supports
ideAdapterSupport();

//Parts Fitment Debugging
//ribbon();
//drive();
//ideAdapterBoard();

//Supports / Brackets / Mounts "Library"
module backSupport() {
    translate([20 - offset_tray_x, offset_tray_y - thickness, thickness - offset_tray_z]) {
        rotate([0, 0, 90]) prism(thickness, 17, tray_z - thickness);
    }
}
module trayMount() {
    from_front = 16.16;
    from_bottom = 6.5;
    diameter = 2.5;
    
    //Front mounting hole
    translate([offset_tray_x - tray_x, from_front - offset_tray_y, from_bottom - tray_z + thickness]) {
        rotate([0, 90, 0]) cylinder(r = diameter / 2, h = thickness * 2.5, center = true, $fn = 15);
    }
    
    //Middle mounting hole, offset 41mm backward from front:
    translate([offset_tray_x - tray_x, 60 + from_front - offset_tray_y, from_bottom - tray_z + thickness]) {
        rotate([0, 90, 0]) cylinder(r = diameter / 2, h = thickness * 2.5, center = true, $fn = 15);
    }
    
    //Rear mounting hole, offset 101mm backward from front:
    translate([offset_tray_x - tray_x, 101.41 + from_front - offset_tray_y, from_bottom - tray_z + thickness]) {
        rotate([0, 90, 0]) cylinder(r = diameter / 2, h = thickness * 2.5, center = true, $fn = 15);
    }
}
module ideAdapterSupport() {
    ide_x = 89.15;
    ide_y = 30.78;
    
    x = 12;
    y = 15;
    z = 6;
    
    translate([offset_tray_x - ide_x - thickness - 0.5, tray_y - offset_tray_y - ide_y - 1, offset_tray_z - tray_z + thickness + 0.25 ]) {     
        difference() {
            cube([x, y, z], center = false);
            
            translate([0,2,z-2]) { cube([x, y, z-2], center = false); }
        }
    }
    
    translate([offset_tray_x - x - thickness - 0.5, tray_y - offset_tray_y - ide_y - 1, offset_tray_z - tray_z + thickness + 0.25 ]) {     
        difference() {
            cube([x, y, z], center = false);
            
            translate([0,2,z-2]) { cube([x, y, z-2], center = false); }
        }
    }
}

module plasticSaverBase() {
    hole_dia=20;
    hole_len=60;
    
    translate([hole_len / 2, -offset_tray_y + hole_dia / 2 + thickness + 5, offset_tray_z - tray_z - 1])
    cheeseHoles(hole_dia, hole_len);
    translate([hole_len / 2, -offset_tray_y + hole_dia / 2 + thickness + 30, offset_tray_z - tray_z - 1])
    cheeseHoles(hole_dia, hole_len);
    translate([hole_len / 2, -offset_tray_y + hole_dia / 2 + thickness + 55, offset_tray_z - tray_z - 1])
    cheeseHoles(hole_dia, hole_len);
    translate([hole_len / 2, -offset_tray_y + hole_dia / 2 + thickness + 80, offset_tray_z - tray_z - 1])
    cheeseHoles(hole_dia, hole_len);
    
    hole_len2=35;
    translate([hole_len2 / 2 + 3, -offset_tray_y + hole_dia / 2 + thickness + 105, offset_tray_z - tray_z - 1])
    cheeseHoles(hole_dia, hole_len2);
    
    hole_dia2=13;
    hole_len3=40;
    translate([hole_len3 / 2 + 3, -offset_tray_y + hole_dia2 / 2 + thickness + 130, offset_tray_z - tray_z - 1])
    cheeseHoles(hole_dia2, hole_len3);
}


//Fitment model "library"
module drive() {
    drive_x = 54;
    drive_y = 71;
    drive_z = 6;
    
    translate([offset_tray_x - drive_x - thickness - 1, offset_tray_y - tray_y + 0.5, offset_tray_z - tray_z + thickness + 0.25 ]) {
        cube([drive_x, drive_y, drive_z], center = false);
    }
}

module ribbon() {
    ribbon_x = 20.4;
    ribbon_y = 52;
    ribbon_z = 0.5;
    ide_edge_offset = 18;
    ide_connector = 28.78;
    
    //18mm from edge of IDE board
    translate([offset_tray_x - ribbon_x - thickness - ide_edge_offset - 0.5, offset_tray_y - ribbon_y - ide_connector, offset_tray_z - tray_z + thickness + 0.25 + 5 ]) {
        cube([ribbon_x, ribbon_y, ribbon_z], center = false);
    }    
    
}
module ideAdapterBoard() {
    ide_x = 89.15;
    ide_y = 30.78;
    ide_z = 8.2;
    
    mount_x = 20.65;
    ide_mount_y = 4.5;
    pwr_mount_y = 4.82;

    translate([offset_tray_x - ide_x - thickness - 0.5, tray_y - offset_tray_y - ide_y, offset_tray_z - tray_z + thickness + 0.25 ]) {     
        difference() {
            cube([ide_x, ide_y, ide_z], center = false);

            // connector 8.89mm x 3.45mm 
            cube([ide_x, ide_y - 8.89, 3.45], center = false);

            translate([0,0,5]) { cube([ide_x, ide_y - 8.89, 3.45], center = false); }
            
            //TODO: Maybe define the mounting holes...
        }
    }
}

//Shapes "library"
module cheeseHoles(d, l, h = 5) {
    //make a stretched cylinder with diameter 'd' and length 'l'
    union() {
        cylinder(r = d / 2, h = h, center = false, $fn = 25);
        translate([-l, -(d / 2), 0]) cube([l, d, h], center = false);
        translate([-l, 0, 0]) cylinder(r = d / 2, h = h, center = false);
    }
}

echo("Model Version", model_version); 
echo("OpenSCAD Version:", version());