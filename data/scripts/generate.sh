#! /bin/bash
mkdir dataset
mkdir dataset/datasources
mkdir dataset/technique_summaries
mkdir dataset/opflows
mkdir dataset/profiles
mkdir dataset/procedures
cd dataset
## Generate Stats
mitre-assistant search -m enterprise -t "stats:adversaries" -e csv -f stats_adversaries.csv
mitre-assistant search -m enterprise -t "stats:malware" -e csv -f stats_malware.csv
mitre-assistant search -m enterprise -t "stats:tools" -e csv -f stats_tools.csv
mitre-assistant search -m enterprise -t "stats:platforms" -e csv -f stats_platforms.csv
mitre-assistant search -m enterprise -t "stats:tactics" -e csv -f stats_tactics.csv
mitre-assistant search -m enterprise -t "stats:datasources" -e csv -f stats_datasources.csv
mitre-assistant search -m enterprise -t "stats:techniques" -e csv -f stats_techniques.csv
#### Discrete Datasets
#
# Datasources
for x in $(xsv select 2 stats_datasources.csv | grep -v -i "datasource" | sort); do mitre-assistant search -m enterprise -t "$x" -e json > ./datasources/techniques_datasources_$x.json;done
for x in $(xsv select 2 stats_datasources.csv | grep -v -i "datasource" | sort); do mitre-assistant search -m enterprise -t "$x" -s -e json > ./datasources/subtechniques_datasources_$x.json;done
# Technique Summaries
for x in $(xsv select 2 stats_techniques.csv | grep -v -i "technique" | sort); do mitre-assistant search -m enterprise -t "$x" -e json > ./technique_summaries/techniques_summary_$x.json;done
# Profiles
for x in $(xsv select 2 stats_adversaries.csv | grep -v -i "adversary" | sort); do mitre-assistant search -m enterprise -t "$x" -e json > profile_adversary_$x.json;done
for x in $(xsv select 2 stats_malware.csv | grep -v -i "malware" | sort); do mitre-assistant search -m enterprise -t "$x" -e json > profile_malware_$x.json;done
for x in $(xsv select 2 stats_tools.csv | grep -v -i "tool" | sort); do mitre-assistant search -m enterprise -t "$x" -e json > profile_tools_$x.json;done
# Opflows
for x in $(xsv select 2 stats_adversaries.csv | grep -v -i "adversary" | sort); do mitre-assistant search -m enterprise -t "$x" -c -e json > ./opflows/opflow_adversary_$x.json;done
for x in $(xsv select 2 stats_malware.csv | grep -v -i "malware" | sort); do mitre-assistant search -m enterprise -t "$x" -c -e json > ./opflows/opflow_malware_$x.json;done
for x in $(xsv select 2 stats_tools.csv | grep -v -i "tool" | sort); do mitre-assistant search -m enterprise -t "$x" -c -e json > ./opflows/opflow_tools_$x.json;done
# Procedures
for x in $(xsv select 2 stats_adversaries.csv | grep -v -i "adversary" | sort); do mitre-assistant search -m enterprise -t "$x:procedures" -c -e json > ./procedures/procedures_adversary_$x.json;done
for x in $(xsv select 2 stats_malware.csv | grep -v -i "malware" | sort); do mitre-assistant search -m enterprise -t "$x:procedures" -c -e json > ./procedures/procedures_malware_$x.json;done
for x in $(xsv select 2 stats_tools.csv | grep -v -i "tool" | sort); do mitre-assistant search -m enterprise -t "$x:procedures" -c -e json > ./procedures/procedures_tools_$x.json;done
# Master Indexing