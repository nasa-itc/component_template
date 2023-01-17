# Component Template

This component template utilizes canned files from the existing [sample component](https://github.com/nasa-itc/sample) to generate a new component to do development in.

Expected utilization:  
* Determine the desired component name
* Create a new submodule for the component via GitHub
* Add the submodule to this project
  * `git submodule init`
  * `git submodule add -f -b main <New_Submodule_Link> ./components/<New_Component_Name>`
* Generate the new files
  * `./generate_template.sh <New_Component_Name>`
    * Note that <New_Component_Name> must be <= 10 characters by default or you'll need to shorten the software bus pipe name after the fact
* Copy the new files to the submodule
  * `mv ./new/* ../<New_Component_Name>/`
* Commit the new files to the submodule
  * `git add * && git add .gitignore`
  * `git commit -m "Initial component template based on version 0.0.0"`
* Add new component to flight software (fsw) in the following files:
  * `./fsw/nos3_defs/cpu1_cfe_es_startup.scr`
  * `./fsw/nos3_defs/targets.cmake`
  * `./fsw/nos3_defs/tables/*`
* Add new component to ground software (gsw) in the following files:
  * `./gsw/cosmos/config/system/nos3_system.txt`
  * `./gsw/cosmos/config/tools/cmd_tlm_server/nos3_cmd_tlm_server.txt`
  * `./gsw/scripts/launch.sh`
