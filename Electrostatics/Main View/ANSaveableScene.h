@interface ANSavableScene : NSObject <NSCoding> {
	NSArray * particles;
	NSArray * springs;
}

@property (readonly) NSArray * particles;
@property (readonly) NSArray * springs;

- (id)initWithParticles:(NSArray *)particles springs:(NSArray *)springs;

@end
