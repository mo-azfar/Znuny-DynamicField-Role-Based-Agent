# --
# Copyright (C) 2022 mo-azfar, https://github.com/mo-azfar/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::System::Ticket::Event::DynamicFieldRoleAgentOwnerResponsibleSet;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::System::Ticket',
    'Kernel::System::DynamicField',
    'Kernel::System::Log',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $TicketObject       = $Kernel::OM->Get('Kernel::System::Ticket');
    my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $LogObject          = $Kernel::OM->Get('Kernel::System::Log');

    # check needed stuff
    NEEDED:
    for my $Needed (qw( Data Event Config UserID )) {
        next NEEDED if $Param{$Needed};

        $LogObject->Log(
            Priority => 'error',
            Message  => "Need $Needed!"
        );
        return;
    }

    if ( !$Param{Data}->{TicketID} ) {
        $LogObject->Log(
            Priority => 'error',
            Message  => "Need TicketID in Data!",
        );
        return;
    }

    #define valid dynamic field types for this event module
    my %ValidDynamicFieldTypes = (
        RoleAgent => 1,
    );

    my $DynamicField = $DynamicFieldObject->DynamicFieldGet(
        Name => $Param{Data}->{FieldName}
    );

    # Skip, if dynamic field type is not valid.
    return if !$ValidDynamicFieldTypes{ $DynamicField->{FieldType} };

    # Skip, if dynamic field config OwnerResponsible is not set.
    my $OwnerResponsibleSet = $DynamicField->{Config}->{OwnerResponsible};

    return if !$OwnerResponsibleSet;

    # Skip, if dynamic field object type is not Ticket.
    return if $DynamicField->{ObjectType} ne 'Ticket';

    my $TicketID  = $Param{Data}->{TicketID};
    my $NewUserID = $Param{Data}->{Value} || '';

    #skip if the new value is empty.
    return if !$NewUserID;

    my $Success = $TicketObject->$OwnerResponsibleSet(
        TicketID  => $TicketID,
        NewUserID => $NewUserID,
        UserID    => 1,
    );

    return 1;
}

1;
