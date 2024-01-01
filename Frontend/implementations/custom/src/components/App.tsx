import { useState } from 'react';
import { PixelStreamingWrapperUser } from './PixelStreamingWrapperUser';
import { PixelStreamingWrapperVendor } from './PixelStreamingWrapperVendor';

export const App = () => {
    
    const [ userType, setUserType] = useState('');
    
    return (
        <div
            style={{
                height: '100%',
                width: '100%'
            }}
        >
            {userType === '' && (
                <div>
                    <button onClick={()=>setUserType('User')}>User</button>
                    <button onClick={()=>setUserType('Vendor')}>Vendor</button>
                </div>
            )}
            {userType === 'User' && (
            <PixelStreamingWrapperUser
                initialSettings={{
                    AutoPlayVideo: true,
                    AutoConnect: true,
                    ss: 'ws://localhost:90/?PlayerType=User',
                    StartVideoMuted: true,
                    HoveringMouse: true,
                    WaitForStreamer: true,
                }}
            />
            )}
            {userType === 'Vendor' && (
            <PixelStreamingWrapperVendor
                initialSettings={{
                    AutoPlayVideo: true,
                    AutoConnect: true,
                    ss: 'ws://localhost:90/?PlayerType=Vendor',
                    StartVideoMuted: true,
                    HoveringMouse: true,
                    WaitForStreamer: true
                }}
            />
            )}
            
        </div>
    );
};
