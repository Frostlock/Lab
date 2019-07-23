# Convert this to python and Flask?
Triangulation of images  
https://github.com/ijmbarr/images-to-triangles

# Tweak the CSS files of underlying webapps?
## Portainer
https://github.com/portainer/portainer/issues/360

### Duplicacy
doesn't look to have a CSS file? maybe run a find/search on it

### cAdvisor
Should work with a transparent background?
CSS here:
https://github.com/google/cadvisor
/pages/assets/styles/

### traefik dashboard
https://github.com/containous/traefik/

Web-UI is written in Angular
See subfolder: https://github.com/containous/traefik/tree/master/webui
(Angular documentation https://angular.io/docs/)

Based on the Angular docs the sass files get converted to css at run time.
I would need to check this out :)

Also worth a look: There is an api for traefik:
https://docs.traefik.io/configuration/api/
check out the /health sub api.
Could I pull this into a widget? :D
