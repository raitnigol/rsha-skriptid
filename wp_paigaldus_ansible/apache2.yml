---
- hosts: webservers
  tasks:
     - name: install apache2
       apt: name=apache2 update_cache=yes state=latest

     - name: Loome public_html kataloog user_ile
       file:
        path=/home/user/public_html
        owner=user
        group=user
        mode=0755
        state=directory
 
     - name: Lubame userdir mod
       apache2_module: name=userdir state=present

     - name: Kopeerime index.html rshaansible
       fetch: src=/var/www/html/index.html dest=./index.html flat=yes

     - name: Kopeerime user_ile index_html
       copy:
         src: ./index.html
         dest: /home/user/public_html/
         owner: user
         group: user
         mode: '0644'
   
     - name: user index.html redigeerimine
       lineinfile: dest=/home/user/public_html/index.html regexp="Apache2 Debain Default Page" line="USERi lehekylg" state=present

     - name: Alglaadimine Apache2
       service:
          name: apache2
          state: restarted
