import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const initMapbox = () => {
  console.log("coucou")
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl }));

    const markers = JSON.parse(mapElement.dataset.markers);
    if (markers.length > 1) {
    markers.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

        // Create a HTML element for your custom marker
        let element = document.createElement('div');
        element.className = 'marker';
        element.style.backgroundImage = `url('${marker.image_url}')`;
        element.style.backgroundSize = 'contain';
        element.style.width = '30px';
        element.style.height = '30px';
        // Pass the element as an argument to the new marker
        new mapboxgl.Marker(element)
          .setLngLat([marker.lng, marker.lat])
          .setPopup(popup)
          .addTo(map);
    });
      const fitMapToMarkers = (map, markers) => {
        const bounds = new mapboxgl.LngLatBounds();
        markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
        map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
        };
        fitMapToMarkers(map, markers);
      } else {
        let element = document.createElement('div');
        element.className = 'marker';
        element.style.backgroundImage = `url('${markers.image_url}')`;
        console.log(markers.image_url);
        element.style.backgroundSize = 'contain';
        element.style.width = '30px';
        element.style.height = '30px';
        console.log(element);
        new mapboxgl.Marker(element)
        .setLngLat([markers.lng, markers.lat])
        .addTo(map);
        const bounds = new mapboxgl.LngLatBounds();
        bounds.extend([ markers.lng, markers.lat ]);
        map.fitBounds(bounds, { padding: 70, maxZoom: 10, duration: 0 });
      };
    };
};


  const addMarkersToMap = (map, markers) => {
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup) // add this
        .addTo(map);
    });
  };

export { initMapbox };
