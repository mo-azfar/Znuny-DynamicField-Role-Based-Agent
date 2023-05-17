# --
# Copyright (C) 2001-2021 OTRS AG, https://otrs.com/
# Copyright (C) 2021 Znuny GmbH, https://znuny.org/
# Copyright (C) 2023 mo-azfar, https://github.com/mo-azfar/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::System::DynamicField::Driver::RoleAgent;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);

use parent qw(Kernel::System::DynamicField::Driver::BaseSelect);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::Main',
);

=head1 NAME

Kernel::System::DynamicField::Driver::Dropdown

=head1 DESCRIPTION

DynamicFields Dropdown Driver delegate

=head1 PUBLIC INTERFACE

This module implements the public interface of L<Kernel::System::DynamicField::Backend>.
Please look there for a detailed reference of the functions.

=head2 new()

usually, you want to create an instance of this
by using Kernel::System::DynamicField::Backend->new();

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # set field behaviors
    $Self->{Behaviors} = {
        'IsACLReducible'               => 1,
        'IsNotificationEventCondition' => 1,
        'IsSortable'                   => 1,
        'IsFiltrable'                  => 1,
        'IsStatsCondition'             => 1,
        'IsCustomerInterfaceCapable'   => 1,
        'IsLikeOperatorCapable'        => 1,
    };

    # get the Dynamic Field Backend custom extensions
    my $DynamicFieldDriverExtensions
        = $Kernel::OM->Get('Kernel::Config')->Get('DynamicFields::Extension::Driver::RoleAgent');

    EXTENSION:
    for my $ExtensionKey ( sort keys %{$DynamicFieldDriverExtensions} ) {

        # skip invalid extensions
        next EXTENSION if !IsHashRefWithData( $DynamicFieldDriverExtensions->{$ExtensionKey} );

        # create a extension config shortcut
        my $Extension = $DynamicFieldDriverExtensions->{$ExtensionKey};

        # check if extension has a new module
        if ( $Extension->{Module} ) {

            # check if module can be loaded
            if (
                !$Kernel::OM->Get('Kernel::System::Main')->RequireBaseClass( $Extension->{Module} )
                )
            {
                die "Can't load dynamic fields backend module"
                    . " $Extension->{Module}! $@";
            }
        }

        # check if extension contains more behaviors
        if ( IsHashRefWithData( $Extension->{Behaviors} ) ) {

            %{ $Self->{Behaviors} } = (
                %{ $Self->{Behaviors} },
                %{ $Extension->{Behaviors} }
            );
        }
    }

    return $Self;
}

sub ValueGet {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub ValueSet {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub ValueValidate {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub SearchSQLGet {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub SearchSQLOrderFieldGet {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub EditFieldRender {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub EditFieldValueGet {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub EditFieldValueValidate {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub DisplayValueRender {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub SearchFieldRender {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub SearchFieldValueGet {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub SearchFieldParameterBuild {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub StatsFieldParameterBuild {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub StatsSearchFieldParameterBuild {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub ReadableValueRender {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub TemplateValueTypeGet {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub RandomValueSet {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub ObjectMatch {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub HistoricalValuesGet {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub ValueLookup {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub BuildSelectionDataGet {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub ColumnFilterValuesGet {
    my ( $Self, %Param ) = @_;

    $Param{DynamicFieldConfig}->{Config}->{PossibleValues} = $Self->PossibleValuesGet(%Param);

    return $Self->next::method(%Param);
}

sub PossibleValuesGet {
    my ( $Self, %Param ) = @_;
	
	my $GroupObject = $Kernel::OM->Get('Kernel::System::Group');
	my $Config = $Param{DynamicFieldConfig}->{Config} || {};
	my $RoleID = $Config->{RoleAgent};
	
	my %UserList = $GroupObject->PermissionRoleUserGet(
        RoleID => $Config->{RoleAgent},
    );
	
	if (%UserList)
	{
		my $UserObject = $Kernel::OM->Get('Kernel::System::User');
		foreach my $UserID (keys %UserList)
		{
			my %User = $UserObject->GetUserData(
				UserID => $UserID,
			);
			
			$UserList{$UserID} = $User{UserFullname};
		}
	}
	
	#Add empty list selection
	$UserList{''} = '-';
    return \%UserList;
}

1;

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<https://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (GPL). If you
did not receive this file, see L<https://www.gnu.org/licenses/gpl-3.0.txt>.

=cut
