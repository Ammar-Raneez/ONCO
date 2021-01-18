import 'react-native-gesture-handler';
import * as React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import Home from './components/Home/Home';
import Login from './components/Login/Login';
import { useState } from 'react';

const Stack = createStackNavigator();

const MyStack = () => {
	const [user, setUser] = useState(null);

	return (
		// This is the Navigator for the screens
		<NavigationContainer>
			<Stack.Navigator
				screenOptions={{
					headerShown: false,
				}}
			>
				{!user ? (
					<>
						{/* if no user logged in then we display the login component */}
						<Stack.Screen name="Login" component={Login} />
					</>
				) : (
					<>
						{/* if the user is logged in then we display the home page component */}
						<Stack.Screen name="Home" component={Home} />
					</>
				)}
			</Stack.Navigator>
		</NavigationContainer>
	);
};

export default MyStack;
