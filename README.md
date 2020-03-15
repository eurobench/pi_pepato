# PEPATO
PErformance indicators of spatiotemporal PATterns of the spinal muscle coordination Output during walking with an exoskeleton


## Data format

[4.5. Electromyography file](https://github.com/aremazeilles/eurobench_documentation/blob/master/data_format.adoc#45-electromyography-file)

[4.9. Gait events file](https://github.com/aremazeilles/eurobench_documentation/blob/master/data_format.adoc#49-gait-events-file)

- Electromiography and Gait events files should be named the same
- File name format:
```
subject_N_emg_R_test_condition.csv
subject_N_gaitEvents_R_test_condition.yml
```


## Octave version >= 5.2.0
(basic functionality)
### Installation required
```
>>> pkg install -forge signal
>>> pkg install -forge statistics
```

### Run
```
>>> pkg load signal
>>> pkg load statistics
>>> pepato_basic('test_data', 'test_data', 'left', {20, 400, 200, 8, 10, 'N=4'}, 'database_octave.mat', []);
``` 
- Set input_folder, output_folder, body_side, config parameters, database filename and list of muscles (optional)
- Format of path folder: path from current folder or full path
- The output file will be saved to the output folder as 'subject_N_runs_R1_R2_R3_pepato_output.yml'


## MATLAB version >= 2015b
(full functionality, advanced GUI)
### Run
```
>>> PEPATO(8, 'left', 'default_config.mat', 'test_database.mat', {'BiFe', 'SeTe', 'VaMe', 'VaLa', 'ReFe', 'TiAn', 'GaMe', 'Sol'});
``` 
- Set GUI font size, body side, name of config file, name of database file and muscle list (optional)