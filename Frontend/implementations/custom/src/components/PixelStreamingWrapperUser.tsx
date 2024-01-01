import React, { useEffect, useRef, useState } from 'react';
import {
    Config,
    AllSettings,
    PixelStreaming
} from '@epicgames-ps/lib-pixelstreamingfrontend-ue5.3';
import { Application, PixelStreamingApplicationStyle } from '@epicgames-ps/lib-pixelstreamingfrontend-ui-ue5.3';

export interface PixelStreamingWrapperProps {
    initialSettings?: Partial<AllSettings>;
}

const PixelStreamingApplicationStyles =
    new PixelStreamingApplicationStyle();
PixelStreamingApplicationStyles.applyStyleSheet();

export const PixelStreamingWrapperUser = ({
    initialSettings
}: PixelStreamingWrapperProps) => {
    // A reference to parent div element that the Pixel Streaming library attaches into:
    const videoParent = useRef<HTMLDivElement>(null);

    const playerUI = useRef<HTMLDivElement>(null);

    // Pixel streaming library instance is stored into this state variable after initialization:
    const [pixelStreaming, setPixelStreaming] = useState<PixelStreaming>();
    const [application, setApplication] = useState<Application>();
    
    // A boolean state variable that determines if the Click to play overlay is shown:
    const [clickToPlayVisible, setClickToPlayVisible] = useState(false);

    // Run on component mount:
    useEffect(() => {
        if (videoParent.current) {
            
            // Attach Pixel Streaming library to videoParent element:
            const config = new Config({ initialSettings, useUrlParams: true});

            // Create a Native DOM delegate instance that implements the Delegate interface class
            const stream = new PixelStreaming(config, {
                videoElementParent: videoParent.current
            });

            stream.addEventListener('playStreamRejected', () => {
                console.log(' playStreamRejected ');

                setClickToPlayVisible(true);
            });

             // Save the library instance into component state so that it can be accessed later:
             setPixelStreaming(stream);

            
            const application = new Application({
                stream,
                onColorModeChanged: (isLightMode) => PixelStreamingApplicationStyles.setColorMode(isLightMode)
            });

            console.log(' config ', config, stream, stream.config.getOptionSettings());

            application.uiFeaturesElement.style.position = 'absolute';
            application.uiFeaturesElement.style.top = '0px';

            playerUI.current.appendChild(application.rootElement);

            setApplication(application);

            // Clean up on component unmount:
            return () => {
                try {
                    stream.disconnect();
                } catch {}
            };
        }
    }, []);

    return (
        <div
            style={{
                width: '100%',
                height: '100%',
            }}
            ref={playerUI}
        >
            <div
                style={{
                    width: '100%',
                    height: '100%'
                }}
                ref={videoParent}
            />
            {clickToPlayVisible && (
                <div
                    style={{
                        position: 'absolute',
                        top: 0,
                        left: 0,
                        width: '100%',
                        height: '100%',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        cursor: 'pointer'
                    }}
                    onClick={() => {
                        pixelStreaming?.play();
                        console.log(' CLICK and request play ')
                        setClickToPlayVisible(false);
                    }}
                >
                    <div>Click to play - User</div>
                </div>
            )}
        </div>
    );
};
