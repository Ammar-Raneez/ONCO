import AccountCircleIcon from '@material-ui/icons/AccountCircle';
import LockIcon from '@material-ui/icons/Lock';
import PersonIcon from '@material-ui/icons/Person';
import React, { useEffect, useState } from 'react';
import { Alert, Animated, Button, Image, SafeAreaView, StyleSheet, Text, View } from 'react-native';
import { TextInput } from 'react-native-gesture-handler';
import LoginWelcome from './LoginWelcome';

const Login = () => {
	const [displayWelcome, setDisplayWelcome] = useState(true);
	const [email, setEmail] = useState('');
	const [password, setPassword] = useState('');
	const [username, setUsername] = useState('');
	const [newPassword, setNewPassword] = useState('');
	const [confirmPassword, setConfirmPassword] = useState('');
	const opacity = useState(new Animated.Value(0.1))[0];

	const [validUserName, setValidUserName] = useState(true);
	const [validEmail, setValidEmail] = useState(true);
	const [validPassword, setValidPassword] = useState(true);
	const [clickForgetPassword, setClickForgetPassword] = useState(false);

	const [validNewPassword, setValidNewPassword] = useState(true);
	const [validConfirmPassword, setValidConfirmPassword] = useState(true);
	const [clickedSignUp, setClickedSignUp] = useState(false);

	// this is to update the displayWelcome component after a given time
	useEffect(() => {
		setTimeout(() => {
			setDisplayWelcome(false);
			// fading animations
			Animated.timing(opacity, {
				toValue: 1,
				duration: 1500,
				useNativeDriver: true,
			}).start();
		}, 5000);
	}, []);

	const onClickLogin = () => {
		let checkEmail = true;
		let checkPassword = true;

		// check if the user has filled the password
		if (!password) {
			setPassword('Enter Password!');
			setValidPassword(false);
			checkPassword = false;
		} else if (password.length < 6) {
			setPassword('Enter at least 6 characters!');
			setValidPassword(false);
			checkPassword = false;
		} else if (password !== 'Enter at least 6 characters!' && password !== 'Enter Password!') {
			setValidPassword(true);
			checkPassword = true;
		} else {
			setValidPassword(false);
			checkPassword = false;
		}

		// check for email format but anyways checking will be further done by FIREBASE
		if (!email.includes('@')) {
			setEmail('Invalid Email Format!');
			setValidEmail(false);
			checkEmail = false;
		} else {
			setValidEmail(true);
			checkEmail = true;
		}

		// NOW WE ARE GOOD TO CHECK WITH FIREBASE AND PROCEED (we can do email validation with firebase as well)
		if (checkEmail && checkPassword) {
			// FIREBASE MAIN CODE GOES HERE!!!

			console.log('You are LOGGING into your account, please hold on...');
			console.log('This is your email: ' + email);
			console.log('This is your password: ' + password);
		}

		// once all the firebase stuff is completed we reset the fields
		// setEmail();
		// setPassword();
	};

	const onClickGoogleLogin = () => {
		// HERE GOES GOOGLE AUTH BY FIREBASE

		console.log('You Clicked Google Auth Login');
	};
	const onClickSignUp = () => {
		let checkEmail = true;
		let checkPassword = true;
		let checkUsername = true;

		// we have to check if all the 3 fields (username, email, password) are all filled
		if (!password && !email) {
			setEmail('Enter Email Address!');
			setPassword('Enter Password!');

			setValidEmail(false);
			checkEmail = false;

			setValidPassword(false);
			checkPassword = false;
		} else if (password.length < 6) {
			setPassword('Enter at least 6 characters!');
			setValidPassword(false);
			checkPassword = false;
		} else if (password !== 'Enter at least 6 characters!' && password !== 'Enter Password!') {
			setValidPassword(true);
			checkPassword = true;
		} else {
			setValidPassword(false);
			checkPassword = false;
		}

		// check for email format but anyways checking will be further done by FIREBASE
		if (!email.includes('@')) {
			setEmail('Invalid Email Format!');
			setValidEmail(false);
			checkEmail = false;
		} else if (email !== 'Enter Email Address!' && email !== 'Invalid Email Format!') {
			setValidEmail(true);
			checkEmail = true;
		} else {
			setValidEmail(false);
			checkEmail = false;
		}

		// VALIDATION for the USERNAME
		if (!username) {
			setUsername('Enter Username!');
			setValidUserName(false);
			checkUsername = false;
		} else if (username !== 'Enter Username!') {
			setValidUserName(true);
			checkUsername = true;
		} else {
			setValidUserName(false);
			checkUsername = false;
		}

		// FIREBASE PART FOR SIGNING UP THE NEW USER
		if (checkEmail && checkPassword && checkUsername) {
			console.log('You are signing up your new account, congrats!!!');

			// FIREBASE SIGN UP PART GOES HERE!!!
		}

		// AFTER ALL THE SIGN UP HAPPENS WE RESET THE INPUT FIELDS AND REDIRECT TO THE LOG IN PAGE
		// setEmail('');
		// setPassword('');
		// setUsername('');

		// setClickedSignUp(false);
	};

	const onClickConfirmChangePass = () => {
		// checking if the new password and confirm password is more than 5 chars and both are equal

		if (!newPassword && !confirmPassword) {
			setNewPassword('Enter New Password!');
			setConfirmPassword('Enter Confirm New Password!');
			setValidNewPassword(false);
			setValidConfirmPassword(false);
		} else if (newPassword.length < 6) {
			setNewPassword('Enter at least 6 characters!');
			setValidNewPassword(false);
		} else if (newPassword !== confirmPassword) {
			setConfirmPassword('Invalid Confirm Password!');
			setValidConfirmPassword(false);
		} else {
			// This means all good to go (BOTH NEW PASSWORD AND CONFIRM PASSWORD ARE EQUAL)
			console.log('This is your new password: ' + password);
			console.log('This is your confirm password: ' + confirmPassword);

			// displays an alert on if any errors occurred or success message
			Alert.alert(
				'Alert Title',
				'My Alert Msg',
				[
					{
						text: 'Ask me later',
						onPress: () => console.log('Ask me later pressed'),
					},
					{
						text: 'Cancel',
						onPress: () => console.log('Cancel Pressed'),
						style: 'cancel',
					},
					{ text: 'OK', onPress: () => console.log('OK Pressed') },
				],
				{ cancelable: false }
			);

			// redirecting when the password is RESET!
			// setClickForgetPassword(false);
			// setNewPassword('');
			// setValidConfirmPassword(true);
			// setValidNewPassword(true);
			// setConfirmPassword('');
		}
	};

	const onClickForgotPassword = () => {
		setClickedSignUp(false);

		let isEmailValidAndPresentInFirebase = true;

		// we set the click forget password to true only when the user has entered valid email stored in the firebase
		if (isEmailValidAndPresentInFirebase) {
			setClickForgetPassword(true);
			setEmail('');
			setPassword('');
			setValidEmail(true);
			setValidPassword(true);
		} else {
			setEmail('This Email is not Registered or invalid!');
			setValidEmail(false);
		}
	};

	return (
		<SafeAreaView style={style.container}>
			{displayWelcome ? (
				<>
					<LoginWelcome />
				</>
			) : (
				<>
					<Animated.View
						style={{
							backgroundColor: '#DEF9FF',
							flex: '1',
							justifyContent: 'space-between',
							opacity,
						}}
					>
						{/* header */}
						<View style={style.login__header}>
							<Image style={style.logo} source={require('../../assets/oncoAssets/oncoLogo.svg')} />
						</View>

						{/* welcome back */}
						<View style={style.login__welcomeBack}>
							{/* <Image style={style.whiteCloud} source={require('../../assets/oncoAssets/whiteCloud.svg')} /> */}
							<Text style={style.login__welcomeBackMessage}>Welcome back!</Text>
						</View>

						{/* login inputs */}
						<View style={style.login__inputContainer}>
							{clickedSignUp ? (
								// THIS SECTION DISPLAYS THE SIGN UP SECTION
								<>
									<Text style={style.login__inputContainerLoginDetails}>Create your new account</Text>

									{/* This is the section when the user has clicked the forget password section */}

									{/* USERNAME */}
									<View
										style={[
											style.login__inputContainerInputsSection,
											!validUserName && style.redField,
											validUserName && style.blueField,
										]}
									>
										<View>
											<AccountCircleIcon />
										</View>
										<TextInput
											style={[style.login__inputContainerInputs, !validUserName && style.invalidTextContent]}
											onChangeText={(text) => {
												setUsername(text);
												setValidUserName(true);
											}}
											textContentType="name"
											placeholder="Username"
											value={username}
											onFocus={() => {
												if (!validUserName) {
													setUsername('');
												}
											}}
										/>
									</View>

									{/* EMAIL */}
									<View
										style={[
											style.login__inputContainerInputsSection,
											!validEmail && style.redField,
											validEmail && style.blueField,
										]}
									>
										<View>
											<PersonIcon />
										</View>
										<TextInput
											style={[style.login__inputContainerInputs, !validEmail && style.invalidTextContent]}
											onChangeText={(text) => {
												setEmail(text);
												setValidEmail(true);
											}}
											textContentType="emailAddress"
											placeholder="Email Address"
											value={email}
											onFocus={() => {
												if (!validEmail) {
													setEmail('');
												}
											}}
										/>
									</View>

									{/* PASSWORD */}
									<View
										style={[
											style.login__inputContainerInputsSection,
											!validPassword && style.redField,
											validPassword && style.blueField,
										]}
									>
										<View>
											<LockIcon />
										</View>
										<TextInput
											style={[style.login__inputContainerInputs, !validPassword && style.invalidTextContent]}
											onChangeText={(text) => {
												setPassword(text);
												setValidPassword(true);
											}}
											textContentType="password"
											placeholder="Password"
											secureTextEntry={validPassword && true}
											value={password}
											onFocus={() => {
												if (!validPassword) {
													setPassword('');
												}
											}}
										/>
									</View>
								</>
							) : !clickForgetPassword ? (
								// THIS DISPLAYS THE LOGIN SECTION ON THE APP
								<>
									<Text style={style.login__inputContainerLoginDetails}>Log in to your existing account</Text>

									{/* This is the section when the user didn't click the forget button */}

									{/* EMAIL */}
									<View
										style={[
											style.login__inputContainerInputsSection,
											!validEmail && style.redField,
											validEmail && style.blueField,
										]}
									>
										<View>
											<PersonIcon />
										</View>
										<TextInput
											style={[style.login__inputContainerInputs, !validEmail && style.invalidTextContent]}
											onChangeText={(text) => {
												setEmail(text);
												setValidEmail(true);
											}}
											textContentType="emailAddress"
											placeholder="Email Address"
											value={email}
											onFocus={() => {
												if (!validEmail) {
													setEmail('');
												}
											}}
										/>
									</View>

									{/* PASSWORD */}
									<View
										style={[
											style.login__inputContainerInputsSection,
											!validPassword && style.redField,
											validPassword && style.blueField,
										]}
									>
										<View>
											<LockIcon />
										</View>
										<TextInput
											style={[style.login__inputContainerInputs, !validPassword && style.invalidTextContent]}
											onChangeText={(text) => {
												setPassword(text);
												setValidPassword(true);
											}}
											textContentType="password"
											placeholder="Password"
											secureTextEntry={validPassword && true}
											value={password}
											onFocus={() => {
												if (!validPassword) {
													setPassword('');
												}
											}}
										/>
									</View>

									{/* FORGOT PASSWORD SECTION */}
									<Text style={style.login__forgotPasswordLink} onPress={onClickForgotPassword}>
										Forgot Password?
									</Text>
								</>
							) : (
								// THIS SECTION DISPLAYS THE CHANGE PASSWORD SECTION ON THE APP
								<>
									<Text style={style.login__inputContainerLoginDetails}>Change your password</Text>

									{/* This is the section when the user has clicked the forget password section */}

									{/* NEW PASSWORD */}
									<View
										style={[
											style.login__inputContainerInputsSection,
											!validNewPassword && style.redField,
											validNewPassword && style.blueField,
										]}
									>
										<View>
											<LockIcon />
										</View>
										<TextInput
											style={[style.login__inputContainerInputs, !validNewPassword && style.invalidTextContent]}
											onChangeText={(text) => {
												setNewPassword(text);
												setValidNewPassword(true);
											}}
											textContentType="password"
											placeholder="New Password"
											secureTextEntry={validNewPassword && true}
											value={newPassword}
											onFocus={() => {
												if (!validNewPassword) {
													setNewPassword('');
												}
											}}
										/>
									</View>

									{/* CONFIRM PASSWORD */}
									<View
										style={[
											style.login__inputContainerInputsSection,
											!validConfirmPassword && style.redField,
											validConfirmPassword && style.blueField,
										]}
									>
										<View>
											<LockIcon />
										</View>
										<TextInput
											style={[style.login__inputContainerInputs, !validConfirmPassword && style.invalidTextContent]}
											onChangeText={(text) => {
												setConfirmPassword(text);
												setValidConfirmPassword(true);
											}}
											textContentType="password"
											placeholder="Confirm Password"
											secureTextEntry={validConfirmPassword && true}
											value={confirmPassword}
											onFocus={() => {
												if (!validConfirmPassword) {
													setConfirmPassword('');
												}
											}}
										/>
									</View>

									{/* GO BACK BUTTON */}
									<Text
										style={style.login__forgotPasswordLink}
										onPress={() => {
											setClickForgetPassword(false);
											setNewPassword('');
											setValidConfirmPassword(true);
											setValidNewPassword(true);
											setConfirmPassword('');
											setClickedSignUp(false);
										}}
									>
										Go back
									</Text>
								</>
							)}
						</View>

						{/* MAIN BUTTONS */}
						<View style={{ margin: 10 }}>
							{clickForgetPassword ? (
								// CONFIRM BUTTON (FOR CHANGING PASSWORDS)
								<View style={style.login__buttons}>
									<Button onPress={onClickConfirmChangePass} title="Confirm" color="#01CDFA" />
								</View>
							) : clickedSignUp ? (
								// SIGN UP BUTTON
								<View style={style.login__buttons}>
									<Button onPress={onClickSignUp} title="Sign Up" color="#01CDFA" />
								</View>
							) : (
								// LOGIN BUTTON
								<View style={style.login__buttons}>
									<Button onPress={onClickLogin} title="Login" color="#01CDFA" />
								</View>
							)}

							<Text style={{ alignSelf: 'center', margin: 15, fontWeight: '600', color: '#2c7c8c' }}>
								Or connect using Google
							</Text>

							{/* GOOGLE LOGIN BUTTON */}
							<View style={style.login__buttonsGOOGLE}>
								<Button onPress={onClickGoogleLogin} bo title="Google" color="red" />
							</View>
						</View>

						{/* Sign Up Footer */}
						<View style={style.login__footer}>
							<Text style={{ alignSelf: 'center', fontWeight: '600', color: '#2c7c8c' }}>
								{!clickedSignUp ? (
									// SIGN UP SECTION
									<>
										Don't have an account?{' '}
										<Text
											style={style.login__signUp}
											onPress={() => {
												setClickedSignUp(true);
												setEmail('');
												setValidEmail(true);
												setPassword('');
												setValidPassword(true);
												setUsername('');
												setValidUserName(true);
											}}
										>
											Sign Up
										</Text>
									</>
								) : (
									// SIGN IN SECTION
									<>
										<Text
											style={style.login__signUp}
											onPress={() => {
												setClickedSignUp(false);
												setClickForgetPassword(false);
												setEmail('');
												setValidEmail(true);
												setPassword('');
												setValidPassword(true);
												setUsername('');
												setValidUserName(true);
											}}
										>
											Sign In
										</Text>{' '}
										to your account.
									</>
								)}
							</Text>
						</View>
					</Animated.View>
				</>
			)}
		</SafeAreaView>
	);
};
const style = StyleSheet.create({
	container: {
		// height: 100,
		flex: 1,
		flexDirection: 'column',
		justifyContent: 'space-between',
	},
	logo: {
		height: 25,
		margin: 55,
		resizeMode: 'contain',
	},
	login__header: {
		backgroundColor: '#01CDFA',
		height: 120,
	},
	login__welcomeBack: {
		alignItems: 'center',
	},
	login__welcomeBackMessage: {
		// fontFamily: 'Arial',
		fontSize: 18,
		fontWeight: '600',
		color: '#3f3f3f',
	},
	login__inputContainer: {
		margin: 30,
	},
	redField: {
		borderColor: 'red',
		borderWidth: 1,
	},
	blueField: {
		borderWidth: 1,
		borderColor: '#01CDFA',
	},
	login__inputContainerLoginDetails: {
		alignSelf: 'center',
		padding: 12,
		fontSize: 13,
		fontWeight: '600',
		color: '#2c7c8c',
	},
	invalidTextContent: {
		color: 'red',
	},
	login__inputContainerInputs: {
		height: 20,
		color: 'grey',
		borderWidth: 0,
		paddingLeft: 5,
		flex: 1,
	},
	login__inputContainerInputsSection: {
		flexDirection: 'row',
		flexWrap: 'wrap',
		borderRadius: 40,
		flex: 1,
		margin: 5,
		color: 'lightgrey',
		padding: 18,
		backgroundColor: 'white',
		alignItems: 'center',
	},
	login__forgotPasswordLink: {
		alignSelf: 'flex-end',
		marginRight: 15,
		marginTop: 5,
		fontWeight: '600',
		color: '#2c7c8c',
	},
	login__buttons: { width: 120, alignSelf: 'center', borderRadius: 30, overflow: 'hidden' },
	login__buttonsGOOGLE: {
		width: 120,
		alignSelf: 'center',
		borderRadius: 5,
		overflow: 'hidden',
	},
	login__footer: {
		position: 'relative',
		backgroundColor: 'white',
		bottom: 0,
		padding: 15,
	},
	login__signUp: {
		color: '#01CDFA',
		fontWeight: '700',
	},
});
export default Login;
