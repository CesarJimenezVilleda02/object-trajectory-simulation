classdef finalAppSimulacionErupcionFinalCompleto_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        GridLayout                      matlab.ui.container.GridLayout
        LeftPanel                       matlab.ui.container.Panel
        v0Spinner                       matlab.ui.control.Spinner
        INGRESELAVELOCIDADINICIALmsLabel  matlab.ui.control.Label
        INGRESEELNGULODEDISPAROdegreesLabel  matlab.ui.control.Label
        thethaSpinner                   matlab.ui.control.Spinner
        INGRESELACONSTANTEDEARRASTRELabel  matlab.ui.control.Label
        C_DSpinner                      matlab.ui.control.Spinner
        INGRESELAALTURAINICIALmLabel    matlab.ui.control.Label
        Y0Spinner                       matlab.ui.control.Spinner
        INGRESELADENSIDADDELAIREkgm3Label  matlab.ui.control.Label
        airDensitySpinner               matlab.ui.control.Spinner
        INGRESELAMASADELPROYECTILkgLabel  matlab.ui.control.Label
        masaSpinner                     matlab.ui.control.Spinner
        INGRESAELDIMETRODELPROYECTILmLabel  matlab.ui.control.Label
        diametroSpinner                 matlab.ui.control.Spinner
        CAMBIOENELTIEMPOLabel           matlab.ui.control.Label
        TsSpinner                       matlab.ui.control.Spinner
        CenterPanel                     matlab.ui.container.Panel
        GridLayout2                     matlab.ui.container.GridLayout
        GridLayout3                     matlab.ui.container.GridLayout
        OPCIONESDESIMULACINButtonGroup  matlab.ui.container.ButtonGroup
        SIMULARVARIABLESButton          matlab.ui.control.RadioButton
        SIMULACINALEATORIAButton        matlab.ui.control.RadioButton
        SIMULARButton                   matlab.ui.control.Button
        UIAxes                          matlab.ui.control.UIAxes
        RightPanel                      matlab.ui.container.Panel
        TituloSeccionLabel              matlab.ui.control.Label
        VelocidadEditFieldLabel         matlab.ui.control.Label
        VelocidadP1EditField            matlab.ui.control.NumericEditField
        Proyectil1Label                 matlab.ui.control.Label
        AceleracinenxEditFieldLabel     matlab.ui.control.Label
        AceleracinenxP1EditField        matlab.ui.control.NumericEditField
        AceleracinenyEditFieldLabel     matlab.ui.control.Label
        AceleracinenyP1EditField        matlab.ui.control.NumericEditField
        AlcanceEditField_2Label         matlab.ui.control.Label
        AlcanceP1EditField              matlab.ui.control.NumericEditField
        AlturaEditField_2Label          matlab.ui.control.Label
        AlturaP1EditField               matlab.ui.control.NumericEditField
        VelocidadEditField_2Label       matlab.ui.control.Label
        VelocidadP2EditField            matlab.ui.control.NumericEditField
        Proyectil2Label                 matlab.ui.control.Label
        AceleracinenxEditField_2Label   matlab.ui.control.Label
        AceleracinenxP2EditField        matlab.ui.control.NumericEditField
        AceleracinenyEditField_2Label   matlab.ui.control.Label
        AceleracinenyP2EditField        matlab.ui.control.NumericEditField
        AlcanceEditFieldLabel           matlab.ui.control.Label
        AlcanceP2EditField              matlab.ui.control.NumericEditField
        AlturaEditFieldLabel            matlab.ui.control.Label
        AlturaP2EditField               matlab.ui.control.NumericEditField
        Proyectil3Label                 matlab.ui.control.Label
        VelocidadEditField_3Label       matlab.ui.control.Label
        VelocidadP3EditField            matlab.ui.control.NumericEditField
        AceleracinenxEditField_3Label   matlab.ui.control.Label
        AceleracinenxP3EditField        matlab.ui.control.NumericEditField
        AceleracinenyEditField_3Label   matlab.ui.control.Label
        AceleracinenyP3EditField        matlab.ui.control.NumericEditField
        AlcanceEditField_3Label         matlab.ui.control.Label
        AlcanceP3EditField              matlab.ui.control.NumericEditField
        AlturaEditField_3Label          matlab.ui.control.Label
        AlturaP3EditField               matlab.ui.control.NumericEditField
        TiempodelasimulacinLabel        matlab.ui.control.Label
        tiempoTranscurridoEditField     matlab.ui.control.NumericEditField
        AlturamximaEditFieldLabel       matlab.ui.control.Label
        AlturamximaP1EditField          matlab.ui.control.NumericEditField
        AlturamximaEditField_2Label     matlab.ui.control.Label
        AlturamximaP2EditField          matlab.ui.control.NumericEditField
        AlturamximaEditField_2Label_2   matlab.ui.control.Label
        AlturamximaP3EditField          matlab.ui.control.NumericEditField
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
        twoPanelWidth = 768;
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: SIMULARButton
        function SIMULARButtonPushed(app, event)
            cla(app.UIAxes)
            clear SIMULARButtonPushed
            
            if app.SIMULARVARIABLESButton.Value
                app.TituloSeccionLabel.Text = "Procesando...";
                app.Proyectil1Label.Text = "Trayectoria con arrastre del aire";
                app.Proyectil2Label.Text = "Trayectoria sin arrastre del aire";
            
                %Parametros de simulación
                V0 = app.v0Spinner.Value;
                C_d = app.C_DSpinner.Value;
                y0 = app.Y0Spinner.Value;
                angulo=app.thethaSpinner.Value;
                thetha = angulo*pi/180.0;
                diametro = app.diametroSpinner.Value;
                masa = app.masaSpinner.Value;
                Rho_air = app.airDensitySpinner.Value;
                Ts = app.TsSpinner.Value;
                
                %Variables
                g = -9.81;
                A = ((diametro^2)*pi)/4;
                K = 1/2 * C_d * Rho_air * A;
                x0 = 0;
                x=x0;
                Vt = (masa * -g) / K;
                n=2;
               
                
                %Con resistencia del aire
                Vdrag=V0;
                V0x = V0 * cos(thetha);
                Vx=V0x;
                y=y0;
                V0y = V0 * sin(thetha);
                Vy=V0y;
                Ad0 = K / Vt * V0^2;
                ad=Ad0;
                ax0 = 0 - Ad0 * cos(thetha);
                ay0 = g - Ad0 * sin(thetha);
                ax=ax0;
                ay=ay0;
                %Sin resistencia del aire
                Nv0x=V0 * cos(thetha);
                Nv0y = V0 * sin(thetha);
                x20 = 0;
                y20 = app.Y0Spinner.Value;
                a2x=0;
                V2x=Nv0x; 
                V2y=Nv0y  ;
                x2=x20;
                y2=y20;
                i=1;
                X(i)=x0;
                Y(i)=y0;
                X2(i)=x20;
                Y2(i)=y20;
                
                
                %Determinar limites de la gráfica
                ymax = ((Nv0y^2)/(2*-g)) + y0;
                Tt = Nv0y/-g + sqrt((Nv0y^2/g^2)-(-2*y0/-g));
                alcance = Tt * Nv0x;
                
                limitX = alcance + 50;
                limitY = ymax + 50;
                
                app.UIAxes.XLim = [0 limitX];
                app.UIAxes.YLim = [0 limitY];
                
                while true

                    %Trayectoria con resistencia del aire
                    Vdrag=sqrt( Vx^2+ Vy^2);
                    thetha = atan2(V0y, V0x);
                    ad=K / masa*Vdrag^n;
                    axant=ax;
                    ax = 0 - K / masa * Vdrag ^ 2 * cos(thetha);
                    ayant=ay;
                    ay = g - K / masa * Vdrag ^ 2 * sin(thetha);
                    Vxant=Vx;
                    Vx = Vx + (ax + axant)/ 2 * Ts;
                    Vyant=Vy;
                    Vy = Vy + (ay + ayant)/ 2 * Ts;

                    x = x + (Ts * Vxant) + (axant * ((Ts^2)/2));
                    y = y + (Ts * Vyant) + (ayant * ((Ts^2)/2));
                    
               
                    app.VelocidadP1EditField.Value = sqrt(Vx^2 + Vy^2);
                    app.AceleracinenxP1EditField.Value = ax;
                    app.AceleracinenyP1EditField.Value = ay;
                    app.AlturaP1EditField.Value = y;
                    app.AlcanceP1EditField.Value = x;

                    a2y = g;
                    VxAnt=V2x;
                    V2x = V2x + (a2x + a2x)/ 2 * Ts;
                    VyAnt=V2y;
                    V2y= V2y + (a2y + a2y)/ 2 * Ts;
                    x2 = x2 + (Ts * VxAnt) + (a2x * ((Ts^2)/2));
                    y2 = y2 + (Ts * VyAnt) + (g * ((Ts^2)/2));
                    app.VelocidadP2EditField.Value = sqrt(V2x^2 + V2y^2);
                    app.AceleracinenxP2EditField.Value = a2x;
                    app.AceleracinenyP2EditField.Value = g;
                    app.AlturaP2EditField.Value = y2;
                    app.AlcanceP2EditField.Value = x2;   
                    %Plot
                    i=i+1;
                    if y2 >= 0
                        X2(i)=x2;
                        Y2(i)=y2;
                    end
                    if y >=0
                        X(i)=x;
                        Y(i)=y;
                    end
                    %t=t+ts;
                    if (y< 0) && (y2 < 0)
                        break
                    end
                    plot(app.UIAxes,X2,Y2,'b','LineWidth',3);
                    hold(app.UIAxes);
                    plot(app.UIAxes,X,Y,'r','LineWidth',3);
                    hold(app.UIAxes);
                    
                    app.tiempoTranscurridoEditField.Value = Ts * i; 
                    
                    pause(Ts)
                    
                    
                end
                app.AlturamximaP1EditField.Value = max(Y2);
                app.AlturamximaP2EditField.Value = max(Y);
                
                legend(app.UIAxes, ["Movimiento sin fuerza de arrastre", "Movimiento con ferza de arrastre"], "Location", "southwest")
                app.TituloSeccionLabel.Text = "Valores finales";
                
            elseif app.SIMULACINALEATORIAButton.Value
                app.TituloSeccionLabel.Text = "Procesando...";
                app.Proyectil1Label.Text = "Trayectoria del objeto 1";
                app.Proyectil2Label.Text = "Trayectoria del objeto 2";
                app.Proyectil3Label.Text = "Trayectoria del objeto 3";
                
                %Parametros de simulación
                
                %Constantes

                C_d = app.C_DSpinner.Value;
                y0 = app.Y0Spinner.Value;
                diametro = app.diametroSpinner.Value;
                masa = app.masaSpinner.Value;
                Rho_air = app.airDensitySpinner.Value;
                Ts = app.TsSpinner.Value;
                g = -9.81;
                A = ((diametro^2)*pi)/4;
                K = 1/2 * C_d * Rho_air * A;
                x01 = 0;
                x02 = 0;
                x03 = 0;
                y01 = y0;
                y02 = y0;
                y03 = y0;
                Vt = (masa * -g) / K;
                i=1;
                X1(i)=x01;
                Y1(i)=y01;
                X2(i)=x02;
                Y2(i)=y02;
                X3(i)=x03;
                Y3(i)=y03;
                n=2;
         
                %Parámetros de la primer trayectoria
                V01 = randi([0 300]);
                y01 = y0;
                angulo1=randi([0 90]);
                thetha1 = angulo1*pi/180.0;
                V0x1 = V01 * cos(thetha1);
                V0y1 = V01 * sin(thetha1);
                Vx1=V0x1;
                Vy1=V0y1;
                y1=y01;
                x1=x01;
                Ad01 = K / Vt * V01^2;
                ax01 = 0 - Ad01 * cos(thetha1);
                ay01 = g - Ad01 * sin(thetha1);
                ax1=ax01;
                ay1=ay01;
                
                %Parámetros de la segunda trayectoria
                V02 = randi([0 300]);
                y02 = y0;
                angulo2=randi([0 90]);
                thetha2 = angulo2*pi/180.0;
                V0x2 = V02 * cos(thetha2);
                V0y2 = V02 * sin(thetha2);
                Vx2=V0x2;
                Vy2=V0y2;
                y2=y02;
                x2=x02;
                Ad02 = K / Vt * V02^2;
                ax02 = 0 - Ad02 * cos(thetha2);
                ay02 = g - Ad02 * sin(thetha2);
                ax2=ax02;
                ay2=ay02;
                %Parámetros de la tercera trayectoria
                V03 = randi([0 300]);
                y03 = y03;
                angulo3=randi([0 90]);
                thetha3 = angulo3*pi/180.0;
                V0x3 = V03 * cos(thetha3);
                V0y3 = V03 * sin(thetha3);
                Vx3=V0x3;
                Vy3=V0y3;
                y3=y03;
                x3=x03;
                Ad03 = K / Vt * V03^2;
                ax03 = 0 - Ad03 * cos(thetha3);
                ay03 = g - Ad03 * sin(thetha3);
                ax3=ax03;
                ay3=ay03;
                %Calcular tamaño de la gráfica
                
                app.UIAxes.XLim = [0 5000];
                app.UIAxes.YLim = [0 5000];
               
                while true
                    if y01 > 0
                        Vdrag1=sqrt( Vx1^2+ Vy1^2);
                        thetha = atan2(V0y1, V0x1);
                        ad1=K / masa*Vdrag1^n;
                        axant1=ax1;
                        ax1 = 0 - K / masa * Vdrag1 ^ 2 * cos(thetha);
                        ayant1=ay1;
                        ay1 = g - K / masa * Vdrag1 ^ 2 * sin(thetha);
                        Vxant1=Vx1;
                        Vx1 = Vx1 + (ax1 + axant1)/ 2 * Ts;
                        Vyant1=Vy1;
                        Vy1 = Vy1 + (ay1 + ayant1)/ 2 * Ts;
                        x1 = x1+ (Ts * Vxant1) + (axant1 * ((Ts^2)/2));
                        y1 = y1 + (Ts * Vyant1) + (ayant1 * ((Ts^2)/2));


                     end
                    
                    if y02 > 0
                        Vdrag2=sqrt( Vx2^2+ Vy2^2);
                        thetha2 = atan2(V0y2, V0x2);
                        ad2=K / masa*Vdrag2^n;
                        axant2=ax2;
                        ax2 = 0 - K / masa * Vdrag2 ^ 2 * cos(thetha2);
                        ayant2=ay2;
                        ay2 = g - K / masa * Vdrag2 ^ 2 * sin(thetha2);
                        Vxant2=Vx2;
                        Vx2 = Vx2 + (ax1 + axant2)/ 2 * Ts;
                        Vyant2=Vy2;
                        Vy2 = Vy2 + (ay1 + ayant2)/ 2 * Ts;
                        x2 = x2+ (Ts * Vxant2) + (axant2 * ((Ts^2)/2));
                        y2 = y2 + (Ts * Vyant2) + (ayant2 * ((Ts^2)/2));


                        

                    end
                    
                    if y03 > 0
                        Vdrag3=sqrt( Vx3^2+ Vy3^2);
                        thetha3 = atan2(V0y3, V0x3);
                        ad3=K / masa*Vdrag3^n;
                        axant3=ax3;
                        ax3 = 0 - K / masa * Vdrag3 ^ 2 * cos(thetha3);
                        ayant3=ay3;
                        ay3 = g - K / masa * Vdrag3 ^ 2 * sin(thetha3);
                        Vxant3=Vx3;
                        Vx3 = Vx3 + (ax3 + axant3)/ 2 * Ts;
                        Vyant3=Vy3;
                        Vy3 = Vy3 + (ay3 + ayant3)/ 2 * Ts;
                        x3 = x3+ (Ts * Vxant3) + (axant3 * ((Ts^2)/2));
                        y3 = y3 + (Ts * Vyant3) + (ayant3 * ((Ts^2)/2));

                    end
                        i=i+1;
                        if y1 >= 0
                            X1(i)=x1;
                            Y1(i)=y1;
                            app.VelocidadP1EditField.Value = sqrt(Vx1^2 + Vy1^2);
                            app.AceleracinenxP1EditField.Value = ax1;
                            app.AceleracinenyP1EditField.Value = ay1;
                            app.AlturaP1EditField.Value = y1;
                            app.AlcanceP1EditField.Value = x1;
                            
                        end
                        if y2 >= 0
                            X2(i)=x2;
                            Y2(i)=y2;
                            app.VelocidadP2EditField.Value = sqrt(Vx2^2 + Vy2^2);
                            app.AceleracinenxP2EditField.Value = ax2;
                            app.AceleracinenyP2EditField.Value = ay2;
                            app.AlturaP2EditField.Value = y2;
                            app.AlcanceP2EditField.Value = x2;
                        end
                        if y3 >= 0
                            X3(i)=x3;
                            Y3(i)=y3;
                            
                            app.VelocidadP3EditField.Value = sqrt(Vx3^2 + Vy3^2);
                            app.AceleracinenxP3EditField.Value = ax3;
                            app.AceleracinenyP3EditField.Value = ay3;
                            app.AlturaP3EditField.Value = y3;
                            app.AlcanceP3EditField.Value = x3;
                        end
                        if (y3 < 0) && (y2 < 0) && (y1 < 0)
                            break
                        end
                        plot(app.UIAxes,X1,Y1,'b','LineWidth',3);
                        hold(app.UIAxes);
                        plot(app.UIAxes,X2,Y2,'r','LineWidth',3);
                        plot(app.UIAxes,X3,Y3,'g','LineWidth',3);
                        hold(app.UIAxes);                        
                        pause(Ts)
                        
                        app.tiempoTranscurridoEditField.Value = Ts * i; 
                    
                end
                
                app.AlturamximaP1EditField.Value = max(Y1);
                app.AlturamximaP2EditField.Value = max(Y2);
                app.AlturamximaP3EditField.Value = max(Y3);
                
                legend(app.UIAxes, ["Objeto 1", "Objeto 2", "Objeto 3"], "Location", "northeast")
                app.TituloSeccionLabel.Text = "Valores finales";
                
            end
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 3x1 grid
                app.GridLayout.RowHeight = {583, 583, 583};
                app.GridLayout.ColumnWidth = {'1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 1;
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 3;
                app.RightPanel.Layout.Column = 1;
            elseif (currentFigureWidth > app.onePanelWidth && currentFigureWidth <= app.twoPanelWidth)
                % Change to a 2x2 grid
                app.GridLayout.RowHeight = {583, 583};
                app.GridLayout.ColumnWidth = {'1x', '1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = [1,2];
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 2;
            else
                % Change to a 1x3 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {170, '1x', 231};
                app.LeftPanel.Layout.Row = 1;
                app.LeftPanel.Layout.Column = 1;
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 2;
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 3;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 860 583];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {170, '1x', 231};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.ForegroundColor = [1 1 1];
            app.LeftPanel.BackgroundColor = [0.9294 0.6941 0.1255];
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create v0Spinner
            app.v0Spinner = uispinner(app.LeftPanel);
            app.v0Spinner.Limits = [0 Inf];
            app.v0Spinner.Position = [11 518 138 22];
            app.v0Spinner.Value = 100;

            % Create INGRESELAVELOCIDADINICIALmsLabel
            app.INGRESELAVELOCIDADINICIALmsLabel = uilabel(app.LeftPanel);
            app.INGRESELAVELOCIDADINICIALmsLabel.HorizontalAlignment = 'center';
            app.INGRESELAVELOCIDADINICIALmsLabel.WordWrap = 'on';
            app.INGRESELAVELOCIDADINICIALmsLabel.FontSize = 8;
            app.INGRESELAVELOCIDADINICIALmsLabel.Position = [6 551 159 21];
            app.INGRESELAVELOCIDADINICIALmsLabel.Text = 'INGRESE LA VELOCIDAD INICIAL (m/s)';

            % Create INGRESEELNGULODEDISPAROdegreesLabel
            app.INGRESEELNGULODEDISPAROdegreesLabel = uilabel(app.LeftPanel);
            app.INGRESEELNGULODEDISPAROdegreesLabel.HorizontalAlignment = 'center';
            app.INGRESEELNGULODEDISPAROdegreesLabel.WordWrap = 'on';
            app.INGRESEELNGULODEDISPAROdegreesLabel.FontSize = 8;
            app.INGRESEELNGULODEDISPAROdegreesLabel.Position = [6 472 159 35];
            app.INGRESEELNGULODEDISPAROdegreesLabel.Text = 'INGRESE EL ÁNGULO DE DISPARO (degrees)';

            % Create thethaSpinner
            app.thethaSpinner = uispinner(app.LeftPanel);
            app.thethaSpinner.Limits = [0 90];
            app.thethaSpinner.Position = [11 443 138 22];
            app.thethaSpinner.Value = 45;

            % Create INGRESELACONSTANTEDEARRASTRELabel
            app.INGRESELACONSTANTEDEARRASTRELabel = uilabel(app.LeftPanel);
            app.INGRESELACONSTANTEDEARRASTRELabel.HorizontalAlignment = 'center';
            app.INGRESELACONSTANTEDEARRASTRELabel.WordWrap = 'on';
            app.INGRESELACONSTANTEDEARRASTRELabel.FontSize = 8;
            app.INGRESELACONSTANTEDEARRASTRELabel.Position = [6 415 159 29];
            app.INGRESELACONSTANTEDEARRASTRELabel.Text = 'INGRESE  LA CONSTANTE DE ARRASTRE';

            % Create C_DSpinner
            app.C_DSpinner = uispinner(app.LeftPanel);
            app.C_DSpinner.Step = 0.1;
            app.C_DSpinner.Limits = [0 Inf];
            app.C_DSpinner.Position = [11 394 138 22];
            app.C_DSpinner.Value = 0.5;

            % Create INGRESELAALTURAINICIALmLabel
            app.INGRESELAALTURAINICIALmLabel = uilabel(app.LeftPanel);
            app.INGRESELAALTURAINICIALmLabel.HorizontalAlignment = 'center';
            app.INGRESELAALTURAINICIALmLabel.WordWrap = 'on';
            app.INGRESELAALTURAINICIALmLabel.FontSize = 8;
            app.INGRESELAALTURAINICIALmLabel.Position = [11 367 138 28];
            app.INGRESELAALTURAINICIALmLabel.Text = 'INGRESE LA ALTURA INICIAL (m)';

            % Create Y0Spinner
            app.Y0Spinner = uispinner(app.LeftPanel);
            app.Y0Spinner.Limits = [0 Inf];
            app.Y0Spinner.Position = [11 346 138 22];
            app.Y0Spinner.Value = 1000;

            % Create INGRESELADENSIDADDELAIREkgm3Label
            app.INGRESELADENSIDADDELAIREkgm3Label = uilabel(app.LeftPanel);
            app.INGRESELADENSIDADDELAIREkgm3Label.HorizontalAlignment = 'center';
            app.INGRESELADENSIDADDELAIREkgm3Label.WordWrap = 'on';
            app.INGRESELADENSIDADDELAIREkgm3Label.FontSize = 8;
            app.INGRESELADENSIDADDELAIREkgm3Label.Position = [11 309 138 28];
            app.INGRESELADENSIDADDELAIREkgm3Label.Text = 'INGRESE LA DENSIDAD DEL AIRE (kg/m^3)';

            % Create airDensitySpinner
            app.airDensitySpinner = uispinner(app.LeftPanel);
            app.airDensitySpinner.Limits = [0 Inf];
            app.airDensitySpinner.Position = [11 288 138 22];
            app.airDensitySpinner.Value = 1.2;

            % Create INGRESELAMASADELPROYECTILkgLabel
            app.INGRESELAMASADELPROYECTILkgLabel = uilabel(app.LeftPanel);
            app.INGRESELAMASADELPROYECTILkgLabel.HorizontalAlignment = 'center';
            app.INGRESELAMASADELPROYECTILkgLabel.WordWrap = 'on';
            app.INGRESELAMASADELPROYECTILkgLabel.FontSize = 8;
            app.INGRESELAMASADELPROYECTILkgLabel.Position = [11 255 138 28];
            app.INGRESELAMASADELPROYECTILkgLabel.Text = 'INGRESE LA MASA DEL PROYECTIL (kg)';

            % Create masaSpinner
            app.masaSpinner = uispinner(app.LeftPanel);
            app.masaSpinner.Step = 5;
            app.masaSpinner.Limits = [0 Inf];
            app.masaSpinner.Position = [11 234 138 22];
            app.masaSpinner.Value = 100;

            % Create INGRESAELDIMETRODELPROYECTILmLabel
            app.INGRESAELDIMETRODELPROYECTILmLabel = uilabel(app.LeftPanel);
            app.INGRESAELDIMETRODELPROYECTILmLabel.HorizontalAlignment = 'center';
            app.INGRESAELDIMETRODELPROYECTILmLabel.WordWrap = 'on';
            app.INGRESAELDIMETRODELPROYECTILmLabel.FontSize = 8;
            app.INGRESAELDIMETRODELPROYECTILmLabel.Position = [11 198 138 28];
            app.INGRESAELDIMETRODELPROYECTILmLabel.Text = 'INGRESA EL DIÁMETRO DEL PROYECTIL (m)';

            % Create diametroSpinner
            app.diametroSpinner = uispinner(app.LeftPanel);
            app.diametroSpinner.Limits = [0 Inf];
            app.diametroSpinner.Position = [11 166 138 22];
            app.diametroSpinner.Value = 0.3;

            % Create CAMBIOENELTIEMPOLabel
            app.CAMBIOENELTIEMPOLabel = uilabel(app.LeftPanel);
            app.CAMBIOENELTIEMPOLabel.HorizontalAlignment = 'center';
            app.CAMBIOENELTIEMPOLabel.WordWrap = 'on';
            app.CAMBIOENELTIEMPOLabel.FontSize = 8;
            app.CAMBIOENELTIEMPOLabel.Position = [11 124 138 28];
            app.CAMBIOENELTIEMPOLabel.Text = 'CAMBIO EN EL TIEMPO';

            % Create TsSpinner
            app.TsSpinner = uispinner(app.LeftPanel);
            app.TsSpinner.Step = 0.1;
            app.TsSpinner.Limits = [0 Inf];
            app.TsSpinner.Position = [11 102 138 22];
            app.TsSpinner.Value = 0.3;

            % Create CenterPanel
            app.CenterPanel = uipanel(app.GridLayout);
            app.CenterPanel.ForegroundColor = [1 1 1];
            app.CenterPanel.BackgroundColor = [1 1 1];
            app.CenterPanel.Layout.Row = 1;
            app.CenterPanel.Layout.Column = 2;

            % Create GridLayout2
            app.GridLayout2 = uigridlayout(app.CenterPanel);
            app.GridLayout2.ColumnWidth = {'1x'};
            app.GridLayout2.RowHeight = {'1.84x', '0.7x'};
            app.GridLayout2.Padding = [2.5 10 2.5 10];
            app.GridLayout2.BackgroundColor = [0.4667 0.6745 0.1882];

            % Create GridLayout3
            app.GridLayout3 = uigridlayout(app.GridLayout2);
            app.GridLayout3.ColumnWidth = {'1x'};
            app.GridLayout3.Layout.Row = 2;
            app.GridLayout3.Layout.Column = 1;
            app.GridLayout3.BackgroundColor = [0 1 0];

            % Create OPCIONESDESIMULACINButtonGroup
            app.OPCIONESDESIMULACINButtonGroup = uibuttongroup(app.GridLayout3);
            app.OPCIONESDESIMULACINButtonGroup.TitlePosition = 'centertop';
            app.OPCIONESDESIMULACINButtonGroup.Title = 'OPCIONES DE SIMULACIÓN';
            app.OPCIONESDESIMULACINButtonGroup.Layout.Row = 1;
            app.OPCIONESDESIMULACINButtonGroup.Layout.Column = 1;

            % Create SIMULARVARIABLESButton
            app.SIMULARVARIABLESButton = uiradiobutton(app.OPCIONESDESIMULACINButtonGroup);
            app.SIMULARVARIABLESButton.Text = 'SIMULAR VARIABLES';
            app.SIMULARVARIABLESButton.Position = [23 -2 151 43];
            app.SIMULARVARIABLESButton.Value = true;

            % Create SIMULACINALEATORIAButton
            app.SIMULACINALEATORIAButton = uiradiobutton(app.OPCIONESDESIMULACINButtonGroup);
            app.SIMULACINALEATORIAButton.Text = 'SIMULACIÓN ALEATORIA';
            app.SIMULACINALEATORIAButton.Position = [195 8 167 22];

            % Create SIMULARButton
            app.SIMULARButton = uibutton(app.GridLayout3, 'push');
            app.SIMULARButton.ButtonPushedFcn = createCallbackFcn(app, @SIMULARButtonPushed, true);
            app.SIMULARButton.BackgroundColor = [0 0 1];
            app.SIMULARButton.FontName = 'Comic Sans MS';
            app.SIMULARButton.FontSize = 20;
            app.SIMULARButton.FontWeight = 'bold';
            app.SIMULARButton.FontColor = [1 1 1];
            app.SIMULARButton.Layout.Row = 2;
            app.SIMULARButton.Layout.Column = 1;
            app.SIMULARButton.Text = 'SIMULAR';

            % Create UIAxes
            app.UIAxes = uiaxes(app.GridLayout2);
            title(app.UIAxes, 'Simulación de erupción volcánica')
            xlabel(app.UIAxes, 'Alcance horizontal en metros')
            ylabel(app.UIAxes, {'Alcance vertical en metros'; ''})
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.XLim = [0 2000];
            app.UIAxes.YLim = [0 3000];
            app.UIAxes.ZLim = [0 2000];
            app.UIAxes.XGrid = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.Layout.Row = 1;
            app.UIAxes.Layout.Column = 1;

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.BackgroundColor = [0.302 0.7451 0.9333];
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 3;

            % Create TituloSeccionLabel
            app.TituloSeccionLabel = uilabel(app.RightPanel);
            app.TituloSeccionLabel.FontWeight = 'bold';
            app.TituloSeccionLabel.Position = [70 560 133 22];
            app.TituloSeccionLabel.Text = 'Valores en tiempo real';

            % Create VelocidadEditFieldLabel
            app.VelocidadEditFieldLabel = uilabel(app.RightPanel);
            app.VelocidadEditFieldLabel.HorizontalAlignment = 'right';
            app.VelocidadEditFieldLabel.Position = [52 518 58 22];
            app.VelocidadEditFieldLabel.Text = 'Velocidad';

            % Create VelocidadP1EditField
            app.VelocidadP1EditField = uieditfield(app.RightPanel, 'numeric');
            app.VelocidadP1EditField.Position = [125 518 100 22];

            % Create Proyectil1Label
            app.Proyectil1Label = uilabel(app.RightPanel);
            app.Proyectil1Label.HorizontalAlignment = 'center';
            app.Proyectil1Label.Position = [8 539 214 22];
            app.Proyectil1Label.Text = 'Proyectil';

            % Create AceleracinenxEditFieldLabel
            app.AceleracinenxEditFieldLabel = uilabel(app.RightPanel);
            app.AceleracinenxEditFieldLabel.HorizontalAlignment = 'right';
            app.AceleracinenxEditFieldLabel.Position = [16 497 94 22];
            app.AceleracinenxEditFieldLabel.Text = 'Aceleración en x';

            % Create AceleracinenxP1EditField
            app.AceleracinenxP1EditField = uieditfield(app.RightPanel, 'numeric');
            app.AceleracinenxP1EditField.Position = [125 497 100 22];

            % Create AceleracinenyEditFieldLabel
            app.AceleracinenyEditFieldLabel = uilabel(app.RightPanel);
            app.AceleracinenyEditFieldLabel.HorizontalAlignment = 'right';
            app.AceleracinenyEditFieldLabel.Position = [16 476 94 22];
            app.AceleracinenyEditFieldLabel.Text = 'Aceleración en y';

            % Create AceleracinenyP1EditField
            app.AceleracinenyP1EditField = uieditfield(app.RightPanel, 'numeric');
            app.AceleracinenyP1EditField.Position = [125 476 100 22];

            % Create AlcanceEditField_2Label
            app.AlcanceEditField_2Label = uilabel(app.RightPanel);
            app.AlcanceEditField_2Label.HorizontalAlignment = 'right';
            app.AlcanceEditField_2Label.Position = [62 455 48 22];
            app.AlcanceEditField_2Label.Text = 'Alcance';

            % Create AlcanceP1EditField
            app.AlcanceP1EditField = uieditfield(app.RightPanel, 'numeric');
            app.AlcanceP1EditField.Position = [125 455 100 22];

            % Create AlturaEditField_2Label
            app.AlturaEditField_2Label = uilabel(app.RightPanel);
            app.AlturaEditField_2Label.HorizontalAlignment = 'right';
            app.AlturaEditField_2Label.Position = [73 434 37 22];
            app.AlturaEditField_2Label.Text = 'Altura';

            % Create AlturaP1EditField
            app.AlturaP1EditField = uieditfield(app.RightPanel, 'numeric');
            app.AlturaP1EditField.Position = [125 434 100 22];

            % Create VelocidadEditField_2Label
            app.VelocidadEditField_2Label = uilabel(app.RightPanel);
            app.VelocidadEditField_2Label.HorizontalAlignment = 'right';
            app.VelocidadEditField_2Label.Position = [46 345 58 22];
            app.VelocidadEditField_2Label.Text = 'Velocidad';

            % Create VelocidadP2EditField
            app.VelocidadP2EditField = uieditfield(app.RightPanel, 'numeric');
            app.VelocidadP2EditField.Position = [119 345 100 22];

            % Create Proyectil2Label
            app.Proyectil2Label = uilabel(app.RightPanel);
            app.Proyectil2Label.HorizontalAlignment = 'center';
            app.Proyectil2Label.Position = [10 373 215 22];
            app.Proyectil2Label.Text = 'Proyectil';

            % Create AceleracinenxEditField_2Label
            app.AceleracinenxEditField_2Label = uilabel(app.RightPanel);
            app.AceleracinenxEditField_2Label.HorizontalAlignment = 'right';
            app.AceleracinenxEditField_2Label.Position = [10 324 94 22];
            app.AceleracinenxEditField_2Label.Text = 'Aceleración en x';

            % Create AceleracinenxP2EditField
            app.AceleracinenxP2EditField = uieditfield(app.RightPanel, 'numeric');
            app.AceleracinenxP2EditField.Position = [119 324 100 22];

            % Create AceleracinenyEditField_2Label
            app.AceleracinenyEditField_2Label = uilabel(app.RightPanel);
            app.AceleracinenyEditField_2Label.HorizontalAlignment = 'right';
            app.AceleracinenyEditField_2Label.Position = [10 303 94 22];
            app.AceleracinenyEditField_2Label.Text = 'Aceleración en y';

            % Create AceleracinenyP2EditField
            app.AceleracinenyP2EditField = uieditfield(app.RightPanel, 'numeric');
            app.AceleracinenyP2EditField.Position = [119 303 100 22];

            % Create AlcanceEditFieldLabel
            app.AlcanceEditFieldLabel = uilabel(app.RightPanel);
            app.AlcanceEditFieldLabel.HorizontalAlignment = 'right';
            app.AlcanceEditFieldLabel.Position = [56 282 48 22];
            app.AlcanceEditFieldLabel.Text = 'Alcance';

            % Create AlcanceP2EditField
            app.AlcanceP2EditField = uieditfield(app.RightPanel, 'numeric');
            app.AlcanceP2EditField.Position = [119 282 100 22];

            % Create AlturaEditFieldLabel
            app.AlturaEditFieldLabel = uilabel(app.RightPanel);
            app.AlturaEditFieldLabel.HorizontalAlignment = 'right';
            app.AlturaEditFieldLabel.Position = [67 261 37 22];
            app.AlturaEditFieldLabel.Text = 'Altura';

            % Create AlturaP2EditField
            app.AlturaP2EditField = uieditfield(app.RightPanel, 'numeric');
            app.AlturaP2EditField.Position = [119 261 100 22];

            % Create Proyectil3Label
            app.Proyectil3Label = uilabel(app.RightPanel);
            app.Proyectil3Label.HorizontalAlignment = 'center';
            app.Proyectil3Label.Position = [11 213 211 22];
            app.Proyectil3Label.Text = 'Proyectil';

            % Create VelocidadEditField_3Label
            app.VelocidadEditField_3Label = uilabel(app.RightPanel);
            app.VelocidadEditField_3Label.HorizontalAlignment = 'right';
            app.VelocidadEditField_3Label.Position = [42 187 58 22];
            app.VelocidadEditField_3Label.Text = 'Velocidad';

            % Create VelocidadP3EditField
            app.VelocidadP3EditField = uieditfield(app.RightPanel, 'numeric');
            app.VelocidadP3EditField.Position = [115 187 100 22];

            % Create AceleracinenxEditField_3Label
            app.AceleracinenxEditField_3Label = uilabel(app.RightPanel);
            app.AceleracinenxEditField_3Label.HorizontalAlignment = 'right';
            app.AceleracinenxEditField_3Label.Position = [6 166 94 22];
            app.AceleracinenxEditField_3Label.Text = 'Aceleración en x';

            % Create AceleracinenxP3EditField
            app.AceleracinenxP3EditField = uieditfield(app.RightPanel, 'numeric');
            app.AceleracinenxP3EditField.Position = [115 166 100 22];

            % Create AceleracinenyEditField_3Label
            app.AceleracinenyEditField_3Label = uilabel(app.RightPanel);
            app.AceleracinenyEditField_3Label.HorizontalAlignment = 'right';
            app.AceleracinenyEditField_3Label.Position = [6 145 94 22];
            app.AceleracinenyEditField_3Label.Text = 'Aceleración en y';

            % Create AceleracinenyP3EditField
            app.AceleracinenyP3EditField = uieditfield(app.RightPanel, 'numeric');
            app.AceleracinenyP3EditField.Position = [115 145 100 22];

            % Create AlcanceEditField_3Label
            app.AlcanceEditField_3Label = uilabel(app.RightPanel);
            app.AlcanceEditField_3Label.HorizontalAlignment = 'right';
            app.AlcanceEditField_3Label.Position = [52 124 48 22];
            app.AlcanceEditField_3Label.Text = 'Alcance';

            % Create AlcanceP3EditField
            app.AlcanceP3EditField = uieditfield(app.RightPanel, 'numeric');
            app.AlcanceP3EditField.Position = [115 124 100 22];

            % Create AlturaEditField_3Label
            app.AlturaEditField_3Label = uilabel(app.RightPanel);
            app.AlturaEditField_3Label.HorizontalAlignment = 'right';
            app.AlturaEditField_3Label.Position = [63 103 37 22];
            app.AlturaEditField_3Label.Text = 'Altura';

            % Create AlturaP3EditField
            app.AlturaP3EditField = uieditfield(app.RightPanel, 'numeric');
            app.AlturaP3EditField.Position = [115 103 100 22];

            % Create TiempodelasimulacinLabel
            app.TiempodelasimulacinLabel = uilabel(app.RightPanel);
            app.TiempodelasimulacinLabel.Position = [8 32 135 22];
            app.TiempodelasimulacinLabel.Text = 'Tiempo de la simulación';

            % Create tiempoTranscurridoEditField
            app.tiempoTranscurridoEditField = uieditfield(app.RightPanel, 'numeric');
            app.tiempoTranscurridoEditField.Position = [146 32 73 22];

            % Create AlturamximaEditFieldLabel
            app.AlturamximaEditFieldLabel = uilabel(app.RightPanel);
            app.AlturamximaEditFieldLabel.HorizontalAlignment = 'right';
            app.AlturamximaEditFieldLabel.Position = [28 413 82 22];
            app.AlturamximaEditFieldLabel.Text = 'Altura máxima';

            % Create AlturamximaP1EditField
            app.AlturamximaP1EditField = uieditfield(app.RightPanel, 'numeric');
            app.AlturamximaP1EditField.Position = [125 413 100 22];

            % Create AlturamximaEditField_2Label
            app.AlturamximaEditField_2Label = uilabel(app.RightPanel);
            app.AlturamximaEditField_2Label.HorizontalAlignment = 'right';
            app.AlturamximaEditField_2Label.Position = [23 240 82 22];
            app.AlturamximaEditField_2Label.Text = 'Altura máxima';

            % Create AlturamximaP2EditField
            app.AlturamximaP2EditField = uieditfield(app.RightPanel, 'numeric');
            app.AlturamximaP2EditField.Position = [120 240 100 22];

            % Create AlturamximaEditField_2Label_2
            app.AlturamximaEditField_2Label_2 = uilabel(app.RightPanel);
            app.AlturamximaEditField_2Label_2.HorizontalAlignment = 'right';
            app.AlturamximaEditField_2Label_2.Position = [18 82 82 22];
            app.AlturamximaEditField_2Label_2.Text = 'Altura máxima';

            % Create AlturamximaP3EditField
            app.AlturamximaP3EditField = uieditfield(app.RightPanel, 'numeric');
            app.AlturamximaP3EditField.Position = [115 82 100 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = finalAppSimulacionErupcionFinalCompleto_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end