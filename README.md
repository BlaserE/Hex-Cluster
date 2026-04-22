# Clustern
![Project Logo](manual/src/assets/images/holy%20crap,%20logo!.png)
<br>
Welcome to the Clustern repository!! This project is intended to be a 'manual' for those interested in making their own home server.

# Philosophy
The Clustern project was created to fill my own need: a centralized server configuration repository. It serves as the template for what I would consider an optimal server environment. 

'Optimal' is subjective for everyone and I keep learning more every day, so things may and will change as I learn more.

The strenght of this project is meant to be it's flexibility.
If something is not exactly like you need it, there are configurations in place and if that doesn't work, you can always fork the project under the same license, so others may benefit from it as well.

I run a server myself, so this project will likely remain in developpment for as long as I do server stuff. Which might be a long time...

In this project, there is a manual provided. It is meant to be simple enough so that anyone can follow it and create their own server environment.
It serves as the foundation of the project. The Ansible playbooks are (mostly) built with the manual as reference.
It is by no means perfect, but I detailed all of it before starting, and I will keep detailing it as I keep learning.

It is made in LaTex, so you can compile it to a pdf if you want. Either for the very latest version or to be certain there are no exploits slipped into the pdf file.

# Ideal Environment
To me, an ideal environment is simply something that works. 
If it works, then it is good. It is good because it works.

Truly, peak engineering. 

Jokes aside, it has happened to all homelabbers that we try a new service or application, it works at first or not at all. That can be either because we made a mistake, a typo or the documentation is unclear.

I refuse to take the blame for my own stupity or lack of awareness, so I wanted to make sure my environment was damn near perfect so I can proudly say "it's not my fault". 

## My ideal Environment
In my cluster, I have a single storage node. No distributed storage of any kind (etcd, longhorn, ceph, etc.) Only one centralized storage node. 

THIS PART STILL NEEDS TO BE FLESHED OUT FURTHER.

# Roadmap
There are a lot of things I need to do before I can even release it for 1.0.0.

Here they are :
- **Finish the manual** <br>
In order to start working on my environment. I need to flesh out the idea before I can get to work on it.

Update: Mostly done. Moving on to making the ansible playbook for it.
- **Create Ansible playbook** <br>
In order to create the machine-specific environment needed.

Update 1: In Progress. Remains to be even tested.

- **K3 Configuration** <br>
To create the cluster of services that will be hosted on kubernetes.

- **Github Action Runners (CI/CD)** <br>
To create workflow actions that will lint my ansible code whenever pushed to `main` or maybe another branch.
Optionally, I can make it work on all branches, granted I use my own self-hosted runner.