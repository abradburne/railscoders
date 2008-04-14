// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function updateLocation(point) {
	document.getElementById('photo_geo_lat').value = point.y; 
	document.getElementById('photo_geo_long').value = point.x;
	map.clearOverlays();
	map.addOverlay(new GMarker(new GLatLng(point.y, point.x)));
}