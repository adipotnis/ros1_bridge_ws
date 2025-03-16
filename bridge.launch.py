# bridge_launch.py
from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        Node(
            package='ros1_bridge',
            executable='dynamic_bridge',
            arguments=['--bridge-all-topics'],
            output='screen'
        )
    ])