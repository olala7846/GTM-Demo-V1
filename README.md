#GTM-DEMO-V1
This is a sample iOS App the integrates with **Google Tag Manager** as a version update notification BE.

#Steps
##Step1 - Create iOS App
Creates your own iOS App with xcode
##Step2 - Install Google Tag Manager SDK
1. Run the cocoapod init command `pod init`
2. Add `pod 'GoogleTagManager` inside **Podfile**
3. Run `pod install`

Now open GTM-DEMO-V1.**xcworkspace** instead of GTM-DEMO-V1.**xcodeproj**, you should be able to use Google Tag Manager SDK!
##Step3 - Setup Container
1. Add default container file into your project, download binary file, remove the version suffix, and place it under `GTM-DEMO-V1/Supporting Files/`, !!! Remember to copy GTM-XXXX to bundle resource !!!
2. Setup container with code
Create TagManager and open container

```obj-c
	// AppDelegate did finish launch with options
	self.tagManager = [TagManager instance];
	[TagContainerOpener openContainerWithId:@"GTM-XXXX"
									  tagManager:self.tagManager
									    openType:kTAGOpenTypePreferFresh
									     timeout:nil
									    notifier:self];
	
```

Set AppDelegate comforms to `TAGContainerOpenerNotifier` and implement

```obj-c
- (void)containerAvailable:(TAGContainer *)container {
  dispatch_async(dispatch_get_main_queue(), ^{
    self.container = container;
  });
}
```
##Step4 - User container varaibles
