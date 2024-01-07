import { useState } from 'react';
import { PlayerUserBasic } from './PlayerUserBasic';
import { MainPageVip } from './MainPageVip';
import { Button, Flex, Typography } from 'antd';
import { PlayerUserType } from '../types';

const boxStyle: React.CSSProperties = {
    width: '100%',
    height: '100%',
  };
const titleStyle: React.CSSProperties = {
    color: '#bbb',
    margin: '10px',
    position: 'absolute',
};
const { Title } = Typography;
  
export const App = () => {
    
    const [ experienceType, setExperienceType] = useState('');
    
    return (
        <div
            style={{
                height: '100%',
                width: '100%',
                backgroundImage: 'linear-gradient(#fff, #aaa)'
            }}
        >
            {experienceType === '' && (
                <>
                    <Title style={titleStyle}>Watchmaker - select your experience type</Title>
                    <Flex style={boxStyle} justify={'space-evenly'} align={'center'} gap="small" wrap="wrap">
                        <Button onClick={() => setExperienceType('Basic')}>Basic</Button>
                        <Button onClick={() => setExperienceType('Vip')}>VIP</Button>
                    </Flex>
                </>
            )}
            
            {experienceType === 'Basic' && (
            <PlayerUserBasic 
                initialSettings={{
                    AutoPlayVideo: true,
                    AutoConnect: true,
                    ss: 'ws://localhost:90/?PlayerUserType=' + PlayerUserType.USER_BASIC,
                    StartVideoMuted: true,
                    HoveringMouse: true,
                    WaitForStreamer: true,
                }} 
            />
            )}
            {experienceType === 'Vip' && (
            <MainPageVip />
            )}
            
        </div>
    );
};
