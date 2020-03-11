# data-viz-SAS

### Folders

<table>

<thead>
<tr>
<th align="left">Folder</th>
<th align="left">Content</th>
</tr>
</thead>

<tbody>


<!-- data_stg0 -->
<tr>

<td align="left">
<code><a target="_blank" rel="noopener noreferrer" href='https://github.com/j-honnacker/data-viz-SAS/tree/master/data_stg0'>data_stg0</a></code>
</td>

<td align="left">
contains the <strong>original data files</strong>
</td>
</tr>


<!-- data_stg1 -->
<tr>

<td align="left">
<code><a target="_blank" rel="noopener noreferrer" href='https://github.com/j-honnacker/data-viz-SAS/tree/master/data_stg1'>data_stg1</a></code>
</td>

<td align="left">
contains <strong>pre-processed data files</strong> created from the original data files in <code><a target="_blank" rel="noopener noreferrer" href='https://github.com/j-honnacker/data-viz-SAS/tree/master/data_stg0'>data_stg0</a></code> by <code><em>dataprep_&ltname&gt.sas</em></code> programs
</td>
</tr>


<!-- data_stg2 -->
<tr>

<td align="left">
<code><a target="_blank" rel="noopener noreferrer" href='https://github.com/j-honnacker/data-viz-SAS/tree/master/data_stg2'>data_stg2</a></code>
</td>

<td align="left">
contains <strong>data files</strong> created from the data files in <code><a target="_blank" rel="noopener noreferrer" href='https://github.com/j-honnacker/data-viz-SAS/tree/master/data_stg1'>data_stg1</a></code> by <code><em>dataprep_&ltname&gt_stg2.sas</em></code> programs
</td>
</tr>


</tbody>

</table>



### Files

<table>

<thead>
<tr>
<th align="left">File</th>
<th align="left">Content</th>
</tr>
</thead>

<tbody>

<!-- dataviz files -->
<tr>

<td align="left">
<b>dataviz</b>_&ltstg&gt_&ltname&gt.sas
</td>

<td align="left">
create visualizations
</td>

</tr>


<!-- dataviz_stg1_rhine_wl_ODS_basics.sas -->
<tr>

<td align="left">
<code><a target="_blank" rel="noopener noreferrer" href="https://github.com/j-honnacker/data-viz-SAS/blob/master/dataviz_stg1_rhine_wl_ODS_basics.sas">
dataviz_stg1_rhine_wl_ODS_basics.sas
</a></code>
</td>

<td align="left">
creates plots and charts from the water level data of the Rhine using ODS (Statistical Graphics) procedures <a href="#dataviz_stg1_rhine_wl_ODS_basics">Details</a>
</td>

</tr>


<!-- dataviz_stg2_ames_townhouses_ODS_basics.sas -->
<tr>

<td align="left">
<code><a target="_blank" rel="noopener noreferrer" href="https://github.com/j-honnacker/data-viz-SAS/blob/master/dataviz_stg2_ames_townhouses_ODS_basics.sas">
dataviz_stg2_ames_townhouses_ODS_basics.sas
</a></code>
</td>

<td align="left">
creates plots and charts from the townhouse data using ODS procedures <a href="#dataviz_stg2_ames_townhouses_ODS_basics">Details</a>
</td>

</tr>



<!-- dataprep files -->
<tr>

<td align="left">
<b>dataprep</b>_&ltstg&gt_&ltname&gt.sas
</td>

<td align="left">
prepare the data for the visualizations
</td>

</tr>


<!-- dataprep_stg1_ames.sas -->
<tr>

<td align="left">
<code><a target="_blank" rel="noopener noreferrer" href="https://github.com/j-honnacker/data-viz-SAS/blob/master/dataprep_stg1_ames.sas">
dataprep_stg1_ames.sas
</a></code>
</td>

<td align="left">
removes outliers as recommended by the data provider
</td>

</tr>


<!-- dataprep_stg1_rhine_wl.sas -->
<tr>

<td align="left">
<code><a target="_blank" rel="noopener noreferrer" href="https://github.com/j-honnacker/data-viz-SAS/blob/master/dataprep_stg1_rhine_wl.sas">
dataprep_stg1_rhine_wl.sas
</a></code>
</td>

<td align="left">
reshapes 23 yearly CSV files and concatenates the results into a single SAS data set <a href="#dataprep_stg1_ames_wl">Details</a>
</td>

</tr>


<!-- dataprep_stg2_ames_townhouses.sas -->
<tr>

<td align="left">
<code><a target="_blank" rel="noopener noreferrer" href="https://github.com/j-honnacker/data-viz-SAS/blob/master/dataprep_stg2_ames_townhouses.sas">
dataprep_stg2_ames_townhouses.sas
</a></code>
</td>

<td align="left">
creates a subset that only contains townhouse data
</td>

</tr>

</tbody>

</table>



<!-- Details: dataviz_stg1_rhine_wl_ODS_basics --> 

#### <a id='dataviz_stg1_rhine_wl_ODS_basics' target="_blank" rel="noopener noreferrer" href='https://github.com/j-honnacker/data-viz-SAS/blob/master/dataviz_stg1_rhine_wl_ODS_basics.sas'>`dataviz_stg1_rhine_wl_ODS_basics.sas`</a>

<img src="https://github.com/j-honnacker/data-viz-SAS/blob/README/viz_stg1_rhine_moving_average.png" alt="Scatter Plot with Moving Averages" width="560"/>



<!-- Details: dataviz_stg2_ames_townhouses.sas --> 

#### <a id='dataviz_stg2_ames_townhouses_ODS_basics' target="_blank" rel="noopener noreferrer" href='https://github.com/j-honnacker/data-viz-SAS/tree/master/dataviz_stg2_ames_townhouses_ODS_basics.sas'>`dataviz_stg2_ames_townhouses_ODS_basics.sas`</a>

<img src="https://github.com/j-honnacker/data-viz-SAS/blob/README/viz_stg2_ames_townhouses_ODS_basics_scatter.png" alt="Scatter Plot with Prediction Ellipse" width="280"/><img src="https://github.com/j-honnacker/data-viz-SAS/blob/README/viz_stg2_ames_townhouses_ODS_basics_box.png" alt="Box Plots, grouped" width="280"/><img src="https://github.com/j-honnacker/data-viz-SAS/blob/README/viz_stg2_ames_townhouses_ODS_basics_bar.png" alt="Bar Plot, grouped" width="280"/><img src="https://github.com/j-honnacker/data-viz-SAS/blob/README/viz_stg2_ames_townhouses_ODS_basics_histogram.png" alt="Histograms, overlayed" width="280"/>



<!-- Details: dataprep_stg1_rhine_wl.sas -->

#### <a id='dataprep_stg1_ames_wl' target="_blank" rel="noopener noreferrer" href='https://github.com/j-honnacker/data-viz-SAS/tree/master/dataprep_stg1_rhine_wl.sas'>`dataprep_stg1_rhine_wl.sas`</a>

<p align="center">
  <img src="https://github.com/j-honnacker/data-viz-SAS/blob/README/dataprep_stg1_rhine_wl.png" alt="" width="600"/>
</p>
