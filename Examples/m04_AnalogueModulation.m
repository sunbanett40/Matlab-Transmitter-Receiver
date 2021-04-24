clear all

frames_per_second = 25;
samples_per_plot = 200;
seconds_per_plot = 4;
max_amplitude = 3;
max_frequency = 20;
min_frequency = 0.1;

gap = 40;
small_plot_height = 100;
big_plot_height = 2*small_plot_height + gap/2;

samples_per_frame = samples_per_plot/frames_per_second/seconds_per_plot;
seconds_per_frame = 1/frames_per_second;
seconds_per_sample = seconds_per_plot/samples_per_plot;
samples_per_second = 1/seconds_per_sample;
max_frequency = min(max_frequency,samples_per_second*0.499);

filter_order = 10*ceil(samples_per_second/min_frequency);
B = fir1(filter_order, 2*min_frequency/samples_per_second);
hd = dfilt.dffir(B);
hd.persistentmemory = true;
hd.state = randn(1,filter_order);

fig1 = figure('Units','pixels','Position',[0,0,3*samples_per_plot+10*gap,big_plot_height+2*small_plot_height+6.5*gap],'Resize','off','Name','Analogue Modulation','MenuBar','none');

pause_button = uicontrol('Style','togglebutton','Units','pixels','Position',[0.5*gap,big_plot_height+2*small_plot_height+5.5*gap-12.5,100,25],'String','Pause','Value',0,'FontSize',12,'ToolTip','Pause the simulation');

options = {'Cosine','Random'};
menu1 = uicontrol('Style','popupmenu','Units','pixels','Position',[2*gap+0.5*samples_per_plot-50,big_plot_height+2*small_plot_height+5.5*gap-12.5,100,25],'String',options,'FontSize',12,'ToolTip','Select the type of the message signal');

options3 = {'Rectifier','Rectifier & LPF','Multiplier','Multiplier & LPF'};
menu3 = uicontrol('Style','popupmenu','Units','pixels','Position',[8*gap+2.5*samples_per_plot-50,big_plot_height+2*small_plot_height+5.5*gap-12.5,100,25],'String',options3,'Value',4,'FontSize',12,'ToolTip','Select the components of the demodulator');


x_limits = [0, seconds_per_plot];

axes11 = axes;
plot11 = plot(nan,'Parent',axes11);
set(axes11,'Units','pixels','Position',[2*gap,2*small_plot_height+4.5*gap,samples_per_plot,big_plot_height],'YLim',[-max_amplitude*1.1,max_amplitude*1.1],'XLim',x_limits,'Box','on','FontSize',12);
set(get(axes11,'XLabel'),'String','t    [s]','FontSize',12)
set(get(axes11,'YLabel'),'String','x(t)','FontSize',12)
set(get(axes11,'Title'),'String','Time domain','FontSize',12)

axes12 = axes;
plot12 = plot(nan,'Parent',axes12);
set(axes12,'Units','pixels','Position',[2*gap,small_plot_height+2.5*gap,samples_per_plot,small_plot_height],'YLim',[-max_amplitude*0.1,max_amplitude*1.1],'XLim',[-max_frequency*0.05,max_frequency*1.05],'Box','on','FontSize',12);
set(get(axes12,'YLabel'),'String','|X(f)|','FontSize',12)
set(get(axes12,'Title'),'String','Frequency domain','FontSize',12)

axes13 = axes;
plot13 = plot(nan,'Parent',axes13);
set(axes13,'Units','pixels','Position',[2*gap,2*gap,samples_per_plot,small_plot_height],'YLim',[-pi*1.1,pi*1.1],'XLim',[-max_frequency*0.05,max_frequency*1.05],'Box','on','FontSize',12);
set(get(axes13,'XLabel'),'String','f    [Hz]','FontSize',12)
set(get(axes13,'YLabel'),'String','arg[X(f)]','FontSize',12)
set(axes13,'YTick',[-pi;0;pi],'yticklabel',{'-p';'0';'p'},'fontname','symbol','XTick',get(axes12,'XTick'));

slider11 = uicontrol('Style','slider','Units','pixels','Min',min_frequency,'Max',max_frequency,'Value',1,'Position',[2*gap,gap-15,samples_per_plot,10],'String','Frequency','ToolTip','Select the (maximum) frequency of the message signal');
slider12 = uicontrol('Style','slider','Units','pixels','Min',0,'Max',max_amplitude,'Value',1,'Position',[gap-15,small_plot_height+2.5*gap,10,small_plot_height],'ToolTip','Select the amplitude of the message signal');
slider13 = uicontrol('Style','slider','Units','pixels','Min',-0.999*pi,'Max',pi,'Value',0,'Position',[gap-15,2*gap,10,small_plot_height],'ToolTip','Select the phase of the message signal');
slider14 = uicontrol('Style','slider','Units','pixels','Min',0,'Max',max_amplitude,'Value',0,'Position',[0.5*gap-15,small_plot_height+2.5*gap,10,small_plot_height],'ToolTip','Select the DC offset of the message signal');





axes21 = axes;
plot21 = plot(nan,'Parent',axes21);
set(axes21,'Units','pixels','Position',[samples_per_plot+5*gap,2*small_plot_height+4.5*gap,samples_per_plot,big_plot_height],'YLim',[-max_amplitude*1.1,max_amplitude*1.1],'XLim',x_limits,'Box','on','FontSize',12);
set(get(axes21,'XLabel'),'String','t    [s]','FontSize',12)
set(get(axes21,'YLabel'),'String','y(t)','FontSize',12)
set(get(axes21,'Title'),'String','Time domain','FontSize',12)

axes22 = axes;
plot22 = plot(nan,'Parent',axes22);
set(axes22,'Units','pixels','Position',[samples_per_plot+5*gap,small_plot_height+2.5*gap,samples_per_plot,small_plot_height],'YLim',[-max_amplitude*0.1,max_amplitude*1.1],'XLim',[-max_frequency*0.05,max_frequency*1.05],'Box','on','FontSize',12);
set(get(axes22,'YLabel'),'String','|Y(f)|','FontSize',12)
set(get(axes22,'Title'),'String','Frequency domain','FontSize',12)

axes23 = axes;
plot23 = plot(nan,'Parent',axes23);
set(axes23,'Units','pixels','Position',[samples_per_plot+5*gap,2*gap,samples_per_plot,small_plot_height],'YLim',[-pi*1.1,pi*1.1],'XLim',[-max_frequency*0.05,max_frequency*1.05],'Box','on','FontSize',12);
set(get(axes23,'XLabel'),'String','f    [Hz]','FontSize',12)
set(get(axes23,'YLabel'),'String','arg[Y(f)]','FontSize',12)
set(axes23,'YTick',[-pi;0;pi],'yticklabel',{'-p';'0';'p'},'fontname','symbol','XTick',get(axes12,'XTick'));

slider21 = uicontrol('Style','slider','Units','pixels','Min',0,'Max',max_frequency,'Value',10,'Position',[samples_per_plot+5*gap,gap-15,samples_per_plot,10],'String','Frequency','ToolTip','Select the frequency of the carrier signal');
slider22 = uicontrol('Style','slider','Units','pixels','Min',0,'Max',max_amplitude,'Value',0,'Position',[samples_per_plot+4*gap-15,small_plot_height+2.5*gap,10,small_plot_height],'ToolTip','Select the amplitude of the noise signal');




axes31 = axes;
plot31 = plot(nan,'Parent',axes31);
set(axes31,'Units','pixels','Position',[2*samples_per_plot+8*gap,2*small_plot_height+4.5*gap,samples_per_plot,big_plot_height],'YLim',[-max_amplitude*1.1,max_amplitude*1.1],'XLim',x_limits,'Box','on','FontSize',12);
set(get(axes31,'XLabel'),'String','t    [s]','FontSize',12)
set(get(axes31,'YLabel'),'String','x(t).y(t)','FontSize',12)
set(get(axes31,'Title'),'String','Time domain','FontSize',12)

axes32 = axes;
plot32 = plot(nan,'Parent',axes32);
set(axes32,'Units','pixels','Position',[2*samples_per_plot+8*gap,small_plot_height+2.5*gap,samples_per_plot,small_plot_height],'YLim',[-max_amplitude*0.1,max_amplitude*1.1],'XLim',[-max_frequency*0.05,max_frequency*1.05],'Box','on','FontSize',12);
set(get(axes32,'YLabel'),'String','|X(f)Y(f)|','FontSize',12)
set(get(axes32,'Title'),'String','Frequency domain','FontSize',12)

axes33 = axes;
plot33 = plot(nan,'Parent',axes33);
set(axes33,'Units','pixels','Position',[2*samples_per_plot+8*gap,2*gap,samples_per_plot,small_plot_height],'YLim',[-pi*1.1,pi*1.1],'XLim',[-max_frequency*0.05,max_frequency*1.05],'Box','on','FontSize',12);
set(get(axes33,'XLabel'),'String','f    [Hz]','FontSize',12)
set(get(axes33,'YLabel'),'String','arg[X(f)Y(f)]','FontSize',12)
set(axes33,'YTick',[-pi;0;pi],'yticklabel',{'-p';'0';'p'},'fontname','symbol','XTick',get(axes12,'XTick'));

slider23 = uicontrol('Style','slider','Units','pixels','Min',-0.999*pi,'Max',pi,'Value',0,'Position',[samples_per_plot+4*gap-15,2*gap,10,small_plot_height],'ToolTip','Select the phase of the carrier signal');




data1 = [];
time = [];

data2 = [];
data3 = [];


frame_index = 1;
sample_index = 0;
slider1_value = nan;

try
    while 1
        tic
        
        if get(pause_button,'Value') == 0
            
            sample_count = round(frame_index*samples_per_frame)-sample_index;
            
            new_time = ((0:sample_count-1)+sample_index)*seconds_per_sample;
            
            frequency1 = get(slider11,'Value');
            amplitude1 = get(slider12,'Value');
            phase1 = get(slider13,'Value');
            dc_offset = get(slider14,'Value');
            
            if isequal(options{get(menu1,'Value')},'Cosine')
                set(slider13,'Visible','on');
                
                new_data1 = amplitude1*cos(2*pi*frequency1*new_time + phase1)+dc_offset;
                
                set(plot12,'XData',[0,0,frequency1,frequency1,frequency1,max_frequency*1.05]);
                set(plot12,'YData',[dc_offset,0,0,amplitude1,0,0]);
                
                set(plot13,'XData',[0,frequency1,frequency1,frequency1,max_frequency*1.05]);
                set(plot13,'YData',[0,0,phase1,0,0]);
                
            elseif isequal(options{get(menu1,'Value')},'Random')
                set(slider13,'Visible','off');
                
                if frequency1 >= min_frequency
                    
                    if get(slider11,'Value') ~= slider1_value
                        slider1_value = get(slider11,'Value');
                        B = fir1(filter_order, 2*frequency1/samples_per_second);
                        temp_state = hd.state;
                        hd = dfilt.dffir(B);
                        hd.persistentmemory = true;
                        hd.state = temp_state;
                    end
                    
                    new_data1 = randn(size(new_time));
                    new_data1 = amplitude1*filter(hd,new_data1)+dc_offset;
                    
                else
                    new_data1 = amplitude1*ones(size(new_time))+dc_offset;
                end
                
                set(plot12,'XData',[0,0,frequency1,frequency1,max_frequency*1.05]);
                set(plot12,'YData',[dc_offset,amplitude1,amplitude1,0,0]);
                
                set(plot13,'XData',[frequency1,frequency1,0,0,frequency1,frequency1,max_frequency*1.05]); % Rob
                set(plot13,'YData',[0,pi,pi,-pi,-pi,0,0]); % Rob
                
            end
            
            
            
            frequency2 = get(slider21,'Value');
            noise_amplitude = get(slider22,'Value');
            phase2 = get(slider23,'Value');
            
            
            noise = randn(size(new_time));
            
            new_data2 = new_data1.*cos(2*pi*frequency2*new_time+phase2)+noise_amplitude*noise;
            
            
            
            
            
            if isequal(options{get(menu1,'Value')},'Cosine')
                
                if frequency2 > 0
                    
                    if frequency2 > frequency1
                        new_frequency1 = frequency2 - frequency1;
                        new_frequency2 = frequency2;
                        new_frequency3 = frequency2 + frequency1;
                        new_amplitude1 = 0.5*amplitude1;
                        new_amplitude2 = dc_offset;
                        new_amplitude3 = 0.5*amplitude1;
                        new_phase1 = phase2 - phase1;
                        new_phase2 = phase2;
                        new_phase3 = phase2 + phase1;
                    else
                        new_frequency1 = frequency1 - frequency2;
                        new_frequency2 = frequency2;
                        new_frequency3 = frequency1 + frequency2;
                        new_amplitude1 = 0.5*amplitude1;
                        new_amplitude2 = dc_offset;
                        new_amplitude3 = 0.5*amplitude1;
                        new_phase1 = phase1 - phase2;
                        new_phase2 = phase2;
                        new_phase3 = phase1 + phase2;
                    end
                    
                    new_phase1 = mod(new_phase1,2*pi);
                    if new_phase1 > pi
                        new_phase1 = new_phase1 - 2*pi;
                    end
                    new_phase3 = mod(new_phase3,2*pi);
                    if new_phase3 > pi
                        new_phase3 = new_phase3 - 2*pi;
                    end
                    
                    
                    set(plot22,'XData',[0, new_frequency1, new_frequency1, new_frequency1, new_frequency2, new_frequency2, new_frequency2, new_frequency3, new_frequency3, new_frequency3, max_frequency*1.05]);
                    set(plot22,'YData',max([0, 0, new_amplitude1, 0, 0, new_amplitude2, 0, 0, new_amplitude3, 0, 0],noise_amplitude));
                    
                    set(plot23,'XData',[0, new_frequency1, new_frequency1, new_frequency1, new_frequency2, new_frequency2, new_frequency2, new_frequency3, new_frequency3, new_frequency3, max_frequency*1.05]);
                    set(plot23,'YData',[0, 0, new_phase1, 0, 0, new_phase2, 0, 0, new_phase3, 0, 0]);
                    
                else
                set(plot22,'XData',[0,0,frequency1,frequency1,frequency1,max_frequency*1.05]);
                set(plot22,'YData',max([dc_offset,0,0,amplitude1,0,0],noise_amplitude));
                
                set(plot23,'XData',[0,0,frequency1,frequency1,frequency1,max_frequency*1.05]);
%                set(plot23,'YData',[mod(-phase2,2*pi),0,0,mod(phase1-phase2,2*pi),0,0]);
                set(plot23,'YData',[-phase2 - ceil((-phase2/2/pi-0.5))*2*pi,0,0,phase1-phase2 - ceil(((phase1-phase2)/2/pi-0.5))*2*pi,0,0]);
                end
            elseif isequal(options{get(menu1,'Value')},'Random')

                if frequency2 > frequency1
                    set(plot22,'XData',[0, frequency2-frequency1, frequency2-frequency1, frequency2,            frequency2,           frequency2,            frequency1+frequency2, frequency1+frequency2, max_frequency*1.05]);
                    set(plot22,'YData',max([0, 0,                     0.5*amplitude1, 0.5*amplitude1, dc_offset, 0.5*amplitude1, 0.5*amplitude1, 0,                     0],noise_amplitude));
                    
                    set(plot23,'XData',[0,frequency2-frequency1,frequency2-frequency1,frequency2,frequency2,frequency2,frequency1+frequency2,frequency1+frequency2,max_frequency*1.05,frequency1+frequency2,frequency1+frequency2,frequency2-frequency1,frequency2-frequency1]);
                    set(plot23,'YData',[0,0,pi,pi,-pi,pi,pi,0,0,0,-pi,-pi,0]);
                    
                elseif frequency2 > 0
                    set(plot22,'XData',[0, 0, frequency2,            frequency2,           frequency2,            frequency1+frequency2, frequency1+frequency2, max_frequency*1.05]);
                    set(plot22,'YData',max([0,                     0.5*amplitude1, 0.5*amplitude1, dc_offset, 0.5*amplitude1, 0.5*amplitude1, 0,                     0],noise_amplitude));
                    
                    set(plot23,'XData',[0,0,frequency2,frequency2,frequency2,frequency1+frequency2,frequency1+frequency2,max_frequency*1.05,frequency1+frequency2,frequency1+frequency2,0,0]);
                    set(plot23,'YData',[0,pi,pi,-pi,pi,pi,0,0,0,-pi,-pi,0]);
                    
                    
                    
                else
                    set(plot22,'XData',[0,                    0,                     frequency1,            frequency1, max_frequency*1.05]);
                    set(plot22,'YData',max([dc_offset*abs(cos(phase2)), amplitude1*abs(cos(phase2)), amplitude1*abs(cos(phase2)), 0,          0],noise_amplitude));
                    
                    set(plot23,'XData',[frequency1,frequency1,0,0,frequency1,frequency1,max_frequency*1.05]); % Rob
                    set(plot23,'YData',[0,pi,pi,-pi,-pi,0,0]); % Rob
                    
                    
                end                
%                 if frequency2 > frequency1
%                     set(plot22,'XData',[0, frequency2-frequency1, frequency2-frequency1, frequency2,            frequency2,           frequency2,            frequency1+frequency2, frequency1+frequency2, max_frequency*1.05]);
%                     set(plot22,'YData',max([0, 0,                     0.5*amplitude1, 0.5*amplitude1, dc_offset, 0.5*amplitude1, 0.5*amplitude1, 0,                     0],noise_amplitude));
%                     
%                     set(plot23,'XData',[0,frequency2-frequency1,frequency2-frequency1,frequency2,frequency2,frequency2,frequency1+frequency2,frequency1+frequency2,max_frequency*1.05]);
%                     set(plot23,'YData',[0,0,2*pi,2*pi,phase2,2*pi,2*pi,0,0]);
%                     
%                 elseif frequency2 > 0
%                     set(plot22,'XData',[0, 0, frequency2,            frequency2,           frequency2,            frequency1+frequency2, frequency1+frequency2, max_frequency*1.05]);
%                     set(plot22,'YData',max([0,                     0.5*amplitude1, 0.5*amplitude1, dc_offset, 0.5*amplitude1, 0.5*amplitude1, 0,                     0],noise_amplitude));
%                     
%                     set(plot23,'XData',[0,0,0,frequency2,frequency2,frequency2,frequency1+frequency2,frequency1+frequency2,max_frequency*1.05]);
%                     set(plot23,'YData',[0,0,2*pi,2*pi,phase2,2*pi,2*pi,0,0]);
%                 else
%                     set(plot22,'XData',[0,                    0,                     frequency1,            frequency1, max_frequency*1.05]);
%                     set(plot22,'YData',max([dc_offset*abs(cos(phase2)), amplitude1*abs(cos(phase2)), amplitude1*abs(cos(phase2)), 0,          0],noise_amplitude));
%                     
%                     set(plot23,'XData',[0,0,0,frequency2,frequency2,frequency2,frequency1+frequency2,frequency1+frequency2,max_frequency*1.05]);
%                     set(plot23,'YData',[0,0,2*pi,2*pi,phase2,2*pi,2*pi,0,0]);
%                 end
                
            end
            
            if frequency2 <= frequency1
                set(axes31,'Visible','off');
                set(axes32,'Visible','off');
                set(axes33,'Visible','off');
                set(menu3,'Visible','off');
                set(plot31,'Visible','off');
                set(plot32,'Visible','off');
                set(plot33,'Visible','off');
            else
                set(axes31,'Visible','on');
                set(plot31,'Visible','on');
                set(menu3,'Visible','on');
                
                
                if isequal(options3{get(menu3,'Value')},'Rectifier')
                    set(axes32,'Visible','off');
                    set(axes33,'Visible','off');
                    set(plot32,'Visible','off');
                    set(plot33,'Visible','off');
                elseif isequal(options3{get(menu3,'Value')},'Rectifier & LPF')
                    set(axes32,'Visible','off');
                    set(axes33,'Visible','off');
                    set(plot32,'Visible','off');
                    set(plot33,'Visible','off');
                elseif isequal(options3{get(menu3,'Value')},'Multiplier')
                    set(axes32,'Visible','on');
                    set(axes33,'Visible','on');
                    set(plot32,'Visible','on');
                    set(plot33,'Visible','on');
                    
                    
                    if isequal(options{get(menu1,'Value')},'Cosine')
                    
                        new_frequency1 = 2*frequency2 - frequency1;
                        new_frequency2 = 2*frequency2;
                        new_frequency3 = 2*frequency2 + frequency1;
                        new_amplitude1 = 0.5*amplitude1;
                        new_amplitude2 = dc_offset;
                        new_amplitude3 = 0.5*amplitude1;
                        new_phase1 = phase2 - phase1;
                        new_phase2 = phase2;
                        new_phase3 = phase2 + phase1;

                        new_phase1 = mod(new_phase1,2*pi);
                        if new_phase1 > pi
                            new_phase1 = new_phase1 - 2*pi;
                        end
                        new_phase3 = mod(new_phase3,2*pi);
                        if new_phase3 > pi
                            new_phase3 = new_phase3 - 2*pi;
                        end


                        set(plot32,'XData',[0,0,frequency1,frequency1,frequency1, new_frequency1, new_frequency1, new_frequency1, new_frequency2, new_frequency2, new_frequency2, new_frequency3, new_frequency3, new_frequency3, max_frequency*1.05]);
                        set(plot32,'YData',max([abs(cos(phase2))*dc_offset,0,0,abs(cos(phase2))*amplitude1,0, 0, new_amplitude1, 0, 0, new_amplitude2, 0, 0, new_amplitude3, 0, 0],noise_amplitude));

                        set(plot33,'XData',[0,frequency1,frequency1,frequency1, new_frequency1, new_frequency1, new_frequency1, new_frequency2, new_frequency2, new_frequency2, new_frequency3, new_frequency3, new_frequency3, max_frequency*1.05]);
                        if cos(phase2) < 0
                            if phase1 <= 0
                            set(plot33,'YData',[0,0,phase1+pi,0, 0, new_phase1, 0, 0, new_phase2, 0, 0, new_phase3, 0, 0]); % do something about phase
                            else
                            set(plot33,'YData',[0,0,phase1-pi,0, 0, new_phase1, 0, 0, new_phase2, 0, 0, new_phase3, 0, 0]); % do something about phase                                
                            end
                        else
                            set(plot33,'YData',[0,0,phase1,0, 0, new_phase1, 0, 0, new_phase2, 0, 0, new_phase3, 0, 0]); % do something about phase
                        end
                    elseif isequal(options{get(menu1,'Value')},'Random')

                         
%                        set(plot33,'XData',[frequency1,frequency1,0,0,frequency1,frequency1,max_frequency*1.05]); % Rob
%                        set(plot33,'YData',[0,pi,pi,-pi,-pi,0,0]); % Rob

                        
                        
                        set(plot32,'XData',[0,0,frequency1,frequency1, 2*frequency2-frequency1, 2*frequency2-frequency1, 2*frequency2,            2*frequency2,           2*frequency2,            frequency1+2*frequency2, frequency1+2*frequency2, max_frequency*1.05]);
                        set(plot32,'YData',max([abs(cos(phase2))*dc_offset,abs(cos(phase2))*amplitude1,abs(cos(phase2))*amplitude1,0, 0,                     0.5*amplitude1, 0.5*amplitude1, dc_offset, 0.5*amplitude1, 0.5*amplitude1, 0,                     0],noise_amplitude));

                        set(plot33,'XData',[frequency1,frequency1,0,0,frequency1,frequency1,2*frequency2-frequency1,2*frequency2-frequency1,2*frequency2,2*frequency2,2*frequency2,frequency1+2*frequency2,frequency1+2*frequency2,max_frequency*1.05,frequency1+2*frequency2,frequency1+2*frequency2,2*frequency2-frequency1,2*frequency2-frequency1]);
                        set(plot33,'YData',[0,pi,pi,-pi,-pi,0,0,pi,pi,-pi,pi,pi,0,0,0,-pi,-pi,0]);
                    
                    end
                    
                    
                elseif isequal(options3{get(menu3,'Value')},'Multiplier & LPF')
                    set(axes32,'Visible','on');
                    set(axes33,'Visible','on');
                    set(plot32,'Visible','on');
                    set(plot33,'Visible','on');
                    
                    if isequal(options{get(menu1,'Value')},'Cosine')
                        
                        set(plot32,'XData',[0,0,frequency1,frequency1,frequency1,frequency2,frequency2,max_frequency*1.05]);
                        set(plot32,'YData',[max([abs(cos(phase2))*dc_offset,0,0,abs(cos(phase2))*amplitude1,0,0],noise_amplitude),0,0]);
                        
                        set(plot33,'XData',[0,frequency1,frequency1,frequency1,max_frequency*1.05]);
                        
                        if cos(phase2) < 0
                            if phase1 <= 0
                            set(plot33,'YData',[0,0,phase1+pi,0,0]);
                            else
                            set(plot33,'YData',[0,0,phase1-pi,0,0]);
                            end
                        else
                            set(plot33,'YData',[0,0,phase1,0,0]);
                        end
                        
                        
                    elseif isequal(options{get(menu1,'Value')},'Random')
                        
                        set(plot32,'XData',[0,0,frequency1,frequency1,frequency2,frequency2,max_frequency*1.05]);
                        set(plot32,'YData',[max([abs(cos(phase2))*dc_offset,abs(cos(phase2))*amplitude1,abs(cos(phase2))*amplitude1,0,0],noise_amplitude),0,0]);
                        
                        set(plot33,'XData',[frequency1,frequency1,0,0,frequency1,frequency1,max_frequency*1.05]); % Rob
                        set(plot33,'YData',[0,pi,pi,-pi,-pi,0,0]); % Rob
                        
                    end
                end
            end
            
            if isequal(options3{get(menu3,'Value')},'Rectifier')
                new_data3 = max(new_data2,0);
            elseif isequal(options3{get(menu3,'Value')},'Rectifier & LPF')
                new_data3 = abs(new_data1) + noise_amplitude*noise;
            elseif isequal(options3{get(menu3,'Value')},'Multiplier')
                new_data3 = 2*new_data2.*cos(2*pi*frequency2*new_time);
            elseif isequal(options3{get(menu3,'Value')},'Multiplier & LPF')
                new_data3 = cos(phase2)*new_data1 + noise_amplitude*noise;
            end
            
            
            old_time = time(max(1,length(time)-samples_per_plot+sample_count+1):end);
            old_data1 = data1(max(1,length(data1)-samples_per_plot+sample_count+1):end);
            old_data2 = data2(max(1,length(data2)-samples_per_plot+sample_count+1):end);
            old_data3 = data3(max(1,length(data3)-samples_per_plot+sample_count+1):end);
            
            time = [old_time,new_time];
            data1 = [old_data1,new_data1];
            data2 = [old_data2,new_data2];
            data3 = [old_data3,new_data3];
            
            set(plot11,'XData',time);
            set(plot11,'YData',data1);
            set(axes11,'XLim',[time(1),max(time(end),seconds_per_plot)]);
            
%            set(plot21,'XData',time);
%            set(plot21,'YData',data2);
%            set(axes21,'XLim',[time(1),max(time(end),seconds_per_plot)]);
            
            set(plot21,'XData',time);
            set(plot21,'YData',data2);
            set(axes21,'XLim',[time(1),max(time(end),seconds_per_plot)]);

            set(plot31,'XData',time);
            set(plot31,'YData',data3);
            set(axes31,'XLim',[time(1),max(time(end),seconds_per_plot)]);

            sample_index = sample_index + sample_count;
            frame_index = frame_index + 1;
            
        end
        
        drawnow
        while toc < seconds_per_frame
        end
    end
end