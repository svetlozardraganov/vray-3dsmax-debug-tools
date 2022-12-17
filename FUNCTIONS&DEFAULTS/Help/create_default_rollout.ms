rollout pivotControls "Pivot Controls"
(
button btnCenter "Center Pivot" width:150
button btnBase "Base Pivot" width:150
button btnOrigin "Origin Pivot" width:150
)

if theNewFloater != undefined then
closeRolloutFloater theNewFloater
theNewFloater = newRolloutFloater "Pivot Tool" 180 120
addRollout pivotControls theNewFloater