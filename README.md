# Simple navigation mesh agent for godot engine

This is a very basic implementation of a navigation mesh agent for Godot Engine 3.x (tested in 3.0.6)

First, copy the folder "NavigationMeshAgent" in the addons folder of your project. Then go to Project -> ProjectSettings -> Plugins and activate it.

The NavigationMeshAgent node should appear in the list of available nodes. To use it, put it as the direct child of a KinematicBody, and select the Navigation type node that will be used to calculate the paths and the target node to be followed by the KinematicBody. This can be done manually in the inspector or by changing the properties "target" and "navigation" via scripting.

Check <a href= "https://github.com/dkovah/NavigationMeshAgent-demo">this</a> also.

The plugin is written in GDScript, so it is probably far from being efficient, and it is lacks of many desirable features, but something is better than nothing, I gess :-)
